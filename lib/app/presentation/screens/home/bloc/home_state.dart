part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final Model model;
  const HomeState(this.model);

  @override
  List<Object> get props => [model];
}

final class HomeInitialState extends HomeState {
  const HomeInitialState(super.model);
}

final class GetProductsHomeState extends HomeState {
  const GetProductsHomeState(super.model);
}

final class LoadingHomeState extends HomeState {
  const LoadingHomeState(super.model);
}

final class ErrorHomeState extends HomeState {
  const ErrorHomeState(super.model, this.message, this.date);

  final String message;
  final DateTime date;

  @override
  List<Object> get props => super.props..addAll([message, date]);
}

class Model extends Equatable {
  final List<ProductModel> products;

  const Model({
    required this.products,
  });

  Model copyWith({
    List<ProductModel>? products,
  }) {
    return Model(
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        products,
      ];
}
