import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../bloc/app_bloc.dart';
import '../../../config/config.dart';
import '../../widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the AppBloc instance from the context
    final bloc = BlocProvider.of<AppBloc>(context);
    // Dispatch the CheckUserAppEvent to the bloc
    bloc.add(CheckUserAppEvent());

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is UserCheckedAppState) {
          // If the user is logged in, replace the current route with '/home'
          if (state.model.isLogged) {
            context.replace('/home');
          } else {
            // If the user is not logged in, replace the current route with '/login'
            context.replace('/login');
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LogoWidget(),
                const SizedBox(height: 40),
                LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.primary, size: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
