import 'dart:convert';

import 'package:prueba_ancient/app/domain/entities/product_model.dart';

import '../../data/source/remote/products_source.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> getProducts();
}

class ProductsRepositoryImpl extends ProductsRepository {
  ProductsRepositoryImpl({
    required this.productsSource,
  });

  final ProductsSource productsSource;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final result = await productsSource.getProducts();
      final json = jsonDecode(result);
      if (json is List) {
        return json.map((e) => ProductModel.fromMap(e)).toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
