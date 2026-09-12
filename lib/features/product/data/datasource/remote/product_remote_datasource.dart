import 'package:ecommerce_app/features/category/data/models/category_model.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> searchProducts({required String searchWord});
  Future<List<ProductModel>> getProductByCategory({required String slug});
}