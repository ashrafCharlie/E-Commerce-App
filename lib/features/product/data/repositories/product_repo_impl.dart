import 'package:ecommerce_app/features/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:ecommerce_app/features/category/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductRemoteDatasource remote;
  ProductRepoImpl({required this.remote});
  @override
  Future<List<ProductEntity>> getProducts() async {
   return await remote.getProducts();
    }

  @override
  Future<List<ProductEntity>> searchProducts({required String searchWord}) async {
    final products = await remote.searchProducts(searchWord: searchWord);
    return products;
  }

  @override
  Future<List<ProductEntity>> getProductByCategory({required String slug}) async {
    return await remote.getProductByCategory(slug: slug);
  }


}