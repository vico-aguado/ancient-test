import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_ancient/app/config/constants.dart';
import 'package:prueba_ancient/app/core/repositories/products_repository.dart';
import 'package:prueba_ancient/app/data/source/remote/products_source.dart';
import 'package:prueba_ancient/app/presentation/screens/home/bloc/home_bloc.dart';

class MockClient extends Mock implements Client {}

void main() {
  group('HomeBloc', () {
    late ProductsRepository productsRepository;
    late MockClient httpClient;
    late ProductsSource productsSource;
    late HomeBloc homeBloc;

    setUp(() {
      httpClient = MockClient();
      productsSource = ProductsSource(httpClient);
      productsRepository =
          ProductsRepositoryImpl(productsSource: productsSource);
      homeBloc = HomeBloc(productsRepository);
    });

    tearDown(() {
      homeBloc.close();
    });

    test('initial state is HomeInitialState', () {
      expect(homeBloc.state, const HomeInitialState(Model(products: [])));
    });

    test('Model', () {
      const Model model = Model(products: []);
      expect(model, model.copyWith());
    });

    test('test GetProductsHomeEvent', () {
      const HomeEvent event = GetProductsHomeEvent();
      expect(
        event,
        equals(
          const GetProductsHomeEvent(),
        ),
      );
      expect(event.props, equals([]));
    });

    test('returns empty list when products source returns empty string',
        () async {
      when(() => httpClient.get(Uri.parse('${AppConstants.urlBase}/products')))
          .thenAnswer((_) async => Response('[]', 200));

      final result = await productsRepository.getProducts();

      expect(result, isEmpty);
    });

    blocTest<HomeBloc, HomeState>(
      'emits LoadingHomeState and GetProductsHomeState on successful getProducts call',
      setUp: () {
        when(() =>
                httpClient.get(Uri.parse('${AppConstants.urlBase}/products')))
            .thenAnswer((_) async => Response('[]', 200));
      },
      build: () => HomeBloc(productsRepository),
      act: (bloc) {
        bloc.add(const GetProductsHomeEvent());
      },
      expect: () => [isA<LoadingHomeState>(), isA<GetProductsHomeState>()],
    );

    blocTest<HomeBloc, HomeState>(
      'emits LoadingHomeState and ErrorHomeState on failed getProducts call',
      setUp: () {
        const error = 'Failed to get products';
        when(() =>
                httpClient.get(Uri.parse('${AppConstants.urlBase}/products')))
            .thenThrow(error);
      },
      build: () => HomeBloc(productsRepository),
      act: (bloc) {
        bloc.add(const GetProductsHomeEvent());
      },
      expect: () => [isA<LoadingHomeState>(), isA<ErrorHomeState>()],
    );
  });
}
