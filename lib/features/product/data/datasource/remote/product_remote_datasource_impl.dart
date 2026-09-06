import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';

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
}