import 'package:ecommerce_app/features/category/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

abstract class  ProductRepo {
  Future<List<ProductEntity>> getProducts();
  Future<List<ProductEntity>> searchProducts({required String searchWord});
  Future<List<ProductEntity>> getProductByCategory({required String slug});
}