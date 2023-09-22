import 'package:http/http.dart';
import 'package:prueba_ancient/app/config/config.dart';

class ProductsSource {
  ProductsSource(this.httpClient);
  final Client httpClient;

  Future<String> getProducts() async {
    try {
      final response = await httpClient.get(
        Uri.parse('${AppConstants.urlBase}/products'),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Error al obtener los productos');
      }
    } catch (e) {
      rethrow;
    }
  }
}
