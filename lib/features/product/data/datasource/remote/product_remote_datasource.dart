import 'package:ecommerce_app/features/product/data/models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getProducts();
}