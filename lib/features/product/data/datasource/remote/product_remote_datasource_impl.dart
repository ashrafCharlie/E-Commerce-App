import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:ecommerce_app/features/category/data/models/category_model.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
    final Dio dio;
    ProductRemoteDatasourceImpl({required this.dio});
  @override
  Future<List<ProductModel>> getProducts() async {
    try{
    final response =await dio.get('https://dummyjson.com/products');
    final List products = response.data['products'];
    return products.map((product) => ProductModel.fromJson(product),).toList();
    } on DioException catch(e){
        throw Exception("Failed to fetch products: ${e.message}");
    }
    catch(e){
      throw Exception("Something went Wrong!: $e");
    }
   
  }

  @override
  Future<List<ProductModel>> searchProducts({required String searchWord})  async {
    try{
      final response = await dio.get('https://dummyjson.com/products/search',
        queryParameters: {
        'q': searchWord,
        }
      );
      final List products = response.data['products'];
      return products.map((product) =>ProductModel.fromJson(product) ,).toList();
    } on DioException catch(e){
      throw Exception(e);
    }catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductModel>> getProductByCategory({required String slug}) async {
    try{
      final response = await dio.get('https://dummyjson.com/products/category/$slug');
      final List products = response.data['products'];
      return products.map((product)=> ProductModel.fromJson(product) ).toList();

    }catch(e){
      throw Exception(e);
    }
  }
}