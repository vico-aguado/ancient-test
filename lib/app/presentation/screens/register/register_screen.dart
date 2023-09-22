import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../core/repositories/user_repository.dart';
import '../../../utils/localization.dart';
import '../../widgets/widgets.dart';
import 'bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        context.read<UserRepository>(),
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                context.pop(); // Navigate back to previous screen
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primary,
              ),
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          // If registration is successful, navigate to home screen
                          if (state is RegisterSuccessRegisterState) {
                            context.go('/home');
                          }
                          // If registration fails, show error dialog
                          if (state is RegisterErrorRegisterState) {
                            showDialogWidget(
                                context: context,
                                content: state.message,
                                onOk: () => context.pop());
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              const LogoWidget(),
                              const SizedBox(height: 38),
                              Text(
                                LocalText.of(context.l10n?.registerTitle),
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              const SizedBox(height: 40),
                              Text(
                                LocalText.of(context.l10n?.registerText),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              const SizedBox(height: 20),
                              TextFieldWidget(
                                  controller: state.model.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  label: LocalText.of(context.l10n?.emailField),
                                  hint: LocalText.of(
                                      context.l10n?.emailHintField)),
                              const SizedBox(height: 20),
                              TextFieldWidget(
                                  obscureText: !state.model.showPass,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      context
                                          .read<RegisterBloc>()
                                          .add(const ShowPassRegisterEvent());
                                    },
                                    icon: Icon(
                                      state.model.showPass
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          AppColors.secondary.withOpacity(0.8),
                                    ),
                                  ),
                                  controller: state.model.passController,
                                  label:
                                      LocalText.of(context.l10n?.passwordField),
                                  hint: LocalText.of(
                                      context.l10n?.passwordHintField)),
                              const SizedBox(height: 20),
                              const SizedBox(height: 20),
                              state is ChangeLoadingStatusRegisterState
                                  ? ButtonWidget(
                                      onPressed: () {},
                                      text: state.message,
                                      color: AppColors.blue,
                                    )
                                  : ButtonWidget(
                                      onPressed: () {
                                        context.read<RegisterBloc>().add(
                                              SendRegisterEvent(context),
                                            );
                                      },
                                      text: LocalText.of(
                                          context.l10n?.registerButton),
                                      color: AppColors.blue,
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
