import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity{
 const ProductModel(
  {required super.productId,
  required super.productTitle, 
  required super.productPrice,
   required super.productDescription, 
   required super.productImage,
    required super.productCategory,
     required super.productRating});

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
      productId: json['id'] as int,
       productTitle: json['title'] as String,
       productPrice: (json['price'] as num).toDouble() ,
        productDescription: json['description'] as String,
         productImage: json['thumbnail'] as String, 
         productCategory: json['category'] as String,
          productRating: (json['rating'] as num).toDouble()
          );

  }
  
}