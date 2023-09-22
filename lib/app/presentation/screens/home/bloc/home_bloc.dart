import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_ancient/app/domain/entities/product_model.dart';

import '../../../../core/repositories/products_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductsRepository productsRepository;

  HomeBloc(this.productsRepository)
      : super(const HomeInitialState(Model(products: []))) {
    on<GetProductsHomeEvent>(_onGetProductsHomeEvent);
  }

// Private method that gets products from the repository and emits a state accordingly
  Future<void> _onGetProductsHomeEvent(
    GetProductsHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    // Emit a LoadingHomeState with the current model
    emit(LoadingHomeState(state.model));
    try {
      // Get products from the repository
      final products = await productsRepository.getProducts();
      // Emit a GetProductsHomeState with a new model containing the retrieved products
      emit(GetProductsHomeState(Model(products: products)));
    } catch (e) {
      // Emit an ErrorHomeState with the current model, the error message and the current time
      emit(ErrorHomeState(state.model, e.toString(), DateTime.now()));
    }
  }
}
