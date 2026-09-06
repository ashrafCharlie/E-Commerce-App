import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable{
  final int productId;
  final String productTitle;
  final double productPrice;
  final String productDescription;
  final String productImage;
  final String productCategory;
  final double productRating;

 const  ProductEntity({
  required this.productId,
   required this.productTitle, 
   required this.productPrice, 
   required this.productDescription, 
   required this.productImage,
    required this.productCategory,
     required this.productRating});

     @override
  List<Object?> get props => [productId,productTitle,productPrice,productDescription,productImage,productCategory,productRating];
}