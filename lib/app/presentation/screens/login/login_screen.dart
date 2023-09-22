import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/app_bloc.dart';
import '../../../config/config.dart';
import '../../../core/repositories/user_repository.dart';
import '../../../utils/localization.dart';
import '../../widgets/widgets.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        context.read<UserRepository>(),
        context.read<AppBloc>(),
      ),
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Form(
                  child: Column(
                    children: [
                      // Login form
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            // If login is successful, navigate to home screen
                            if (state is SuccessLoginState) {
                              context.replace('/home');
                            }
                            // If login fails, show error message
                            if (state is ErrorLoginState) {
                              showDialogWidget(
                                  context: context,
                                  content: state.message,
                                  onOk: () => context.pop());
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              children: [
                                const SizedBox(height: 30),
                                const LogoWidget(),
                                const SizedBox(height: 38),
                                Text(
                                  LocalText.of(context.l10n?.loginTitle),
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 40),
                                Text(
                                  LocalText.of(context.l10n?.loginText),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 40),
                                // Email field
                                TextFieldWidget(
                                    key: const Key('emailTextField'),
                                    controller: state.model.emailController,
                                    label:
                                        LocalText.of(context.l10n?.emailField),
                                    hint: LocalText.of(
                                        context.l10n?.emailHintField)),
                                const SizedBox(height: 20),
                                // Password field
                                TextFieldWidget(
                                    key: const Key('passTextField'),
                                    controller: state.model.passController,
                                    obscureText: !state.model.showPass,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        context
                                            .read<LoginBloc>()
                                            .add(const ShowPassLoginEvent());
                                      },
                                      icon: Icon(
                                        state.model.showPass
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.secondary
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    label: LocalText.of(
                                        context.l10n?.passwordField),
                                    hint: LocalText.of(
                                        context.l10n?.passwordHintField)),
                                const SizedBox(height: 20),
                                // Login button
                                state is LoadingLoginState
                                    ? ButtonWidget(
                                        onPressed: () {},
                                        text:
                                            '${LocalText.of(context.l10n?.loading)}...',
                                      )
                                    : ButtonWidget(
                                        key: const Key('loginButton'),
                                        onPressed: () {
                                          context.read<LoginBloc>().add(
                                                const SendLoginEvent(),
                                              );
                                        },
                                        text: LocalText.of(
                                            context.l10n?.loginButton),
                                      ),
                                const SizedBox(height: 30),
                                // Register link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocalText.of(
                                          context.l10n?.loginRegisterText),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    TextButton(
                                      key: const Key('registerButton'),
                                      onPressed: () {
                                        context.push('/register');
                                      },
                                      child: Text(
                                        LocalText.of(
                                            context.l10n?.loginRegisterButton),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
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
          )),
    );
  }
}
