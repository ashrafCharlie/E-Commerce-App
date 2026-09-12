import 'package:ecommerce_app/features/category/domain/entities/category_entity.dart';

class CategoryModel extends  CategoryEntity {
 const CategoryModel({required super.name, required super.slug, required super.url});

 factory CategoryModel.fromJson(Map<String,dynamic> json){
   return CategoryModel(
       name: json['name'] as String,
       slug: json['slug'] as String,
       url: json['url']  as String);
 }
}