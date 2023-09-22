import 'package:prueba_ancient/app/domain/entities/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductModel', () {
    test('should create a ProductModel instance', () {
      const product = ProductModel(
        id: 1,
        title: 'Product 1',
        price: 10.0,
        description: 'Description of Product 1',
        category: 'Category 1',
        image: 'image1.png',
        rating: RatingModel(rate: 4.5, count: 10),
      );

      expect(product.id, equals(1));
      expect(product.title, equals('Product 1'));
      expect(product.price, equals(10.0));
      expect(product.description, equals('Description of Product 1'));
      expect(product.category, equals('Category 1'));
      expect(product.image, equals('image1.png'));
      expect(product.rating.rate, equals(4.5));
      expect(product.rating.count, equals(10));
    });

    test('should convert ProductModel to and from JSON', () {
      const product = ProductModel(
        id: 1,
        title: 'Product 1',
        price: 10.0,
        description: 'Description of Product 1',
        category: 'Category 1',
        image: 'image1.png',
        rating: RatingModel(rate: 4.5, count: 10),
      );

      final json = product.toJson();
      final fromJson = ProductModel.fromJson(json);

      expect(fromJson.id, equals(product.id));
      expect(fromJson.title, equals(product.title));
      expect(fromJson.price, equals(product.price));
      expect(fromJson.description, equals(product.description));
      expect(fromJson.category, equals(product.category));
      expect(fromJson.image, equals(product.image));
      expect(fromJson.rating.rate, equals(product.rating.rate));
      expect(fromJson.rating.count, equals(product.rating.count));
    });

    test('should return a list of ProductModel props', () {
      const product = ProductModel(
        id: 1,
        title: 'Product 1',
        price: 10.0,
        description: 'Description of Product 1',
        category: 'Category 1',
        image: 'image1.png',
        rating: RatingModel(rate: 4.5, count: 10),
      );

      final props = product.props;

      expect(props.length, equals(7));
      expect(props[0], equals(product.id));
      expect(props[1], equals(product.title));
      expect(props[2], equals(product.price));
      expect(props[3], equals(product.description));
      expect(props[4], equals(product.category));
      expect(props[5], equals(product.image));
      expect(props[6], equals(product.rating));
    });
  });

  group('RatingModel', () {
    test('should create a RatingModel instance', () {
      const rating = RatingModel(rate: 4.5, count: 10);

      expect(rating.rate, equals(4.5));
      expect(rating.count, equals(10));
    });

    test('should convert RatingModel to and from JSON', () {
      const rating = RatingModel(rate: 4.5, count: 10);

      final json = rating.toJson();
      final fromJson = RatingModel.fromJson(json);

      expect(fromJson.rate, equals(rating.rate));
      expect(fromJson.count, equals(rating.count));
    });

    test('should return a list of RatingModel props', () {
      const rating = RatingModel(rate: 4.5, count: 10);

      final props = rating.props;

      expect(props.length, equals(2));
      expect(props[0], equals(rating.rate));
      expect(props[1], equals(rating.count));
    });
  });
}
