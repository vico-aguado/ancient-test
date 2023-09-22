import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:prueba_ancient/app/bloc/app_bloc.dart';
import 'package:prueba_ancient/app/config/colors.dart';

import '../../../core/repositories/products_repository.dart';
import '../../../utils/localization.dart';
import 'bloc/home_bloc.dart';
import 'widgets/product_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    return BlocProvider(
      create: (context) => HomeBloc(
        context.read<ProductsRepository>(),
      )..add(
          const GetProductsHomeEvent(),
        ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LocalText.of(context.l10n?.products)),
              actions: [
                BlocBuilder<AppBloc, AppState>(
                  buildWhen: (previous, current) =>
                      current is ThemeChangedAppState,
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        appBloc.add(
                            ChangeThemeAppEvent(!appBloc.state.model.isDark));
                      },
                      icon: Icon(!appBloc.state.model.isDark
                          ? Icons.dark_mode
                          : Icons.light_mode),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    appBloc.add(LogoutAppEvent());
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: SafeArea(
              bottom: false,
              child: state is LoadingHomeState
                  ? Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: AppColors.primary,
                        size: 80,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        final product = state.model.products[index];
                        return ProductCardWidget(product: product);
                      },
                      itemCount: state.model.products.length,
                    ),
            ),
          );
        },
      ),
    );
  }
}
