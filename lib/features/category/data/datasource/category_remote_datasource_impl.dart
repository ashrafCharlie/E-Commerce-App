import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/category/data/datasource/category_remote_datasource.dart';
import 'package:ecommerce_app/features/category/data/models/category_model.dart';

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource{
  final Dio dio;
  CategoryRemoteDatasourceImpl({required this.dio});
  @override
  Future<List<CategoryModel>> getCategories() async {
   try{
     final  response = await dio.get("https://dummyjson.com/products/categories");
     final List categories = response.data;
     return categories.map((category) =>CategoryModel.fromJson(category) ,).toList();
   }catch(e){
     throw Exception(e);
   }
  }

}