import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_ancient/app/config/config.dart';
import 'package:prueba_ancient/app/core/repositories/products_repository.dart';
import 'package:prueba_ancient/app/data/source/remote/products_source.dart';
import 'package:prueba_ancient/app/utils/localization.dart';

import 'bloc/app_bloc.dart';
import 'core/preferences.dart';
import 'core/repositories/user_repository.dart';
import 'data/source/remote/user_source.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserSource>(
          create: (context) => UserSource(FirebaseAuth.instance),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            userSource: context.read<UserSource>(),
          ),
        ),
        RepositoryProvider<ProductsSource>(
          create: (context) => ProductsSource(http.Client()),
        ),
        RepositoryProvider<ProductsRepository>(
          create: (context) => ProductsRepositoryImpl(
            productsSource: context.read<ProductsSource>(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(
          context.read<UserRepository>(),
          preferences,
        ),
        child: BlocConsumer<AppBloc, AppState>(
          listener: (contextBloc, state) {
            if (state is LogoutAppState) {
              appRouter.replace('/login');
            }
          },
          buildWhen: (previous, current) =>
              current is ThemeChangedAppState || current is LogoutAppState,
          builder: (context, state) {
            return MaterialApp.router(
              title: LocalText.of(context.l10n?.title),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              darkTheme: AppTheme(isDarkmode: true).getTheme(),
              theme: AppTheme(isDarkmode: false).getTheme(),
              themeMode: state.model.isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
