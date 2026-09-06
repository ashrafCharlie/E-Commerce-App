import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

abstract class  ProductRepo {
  Future<List<ProductEntity>> getProducts();
}