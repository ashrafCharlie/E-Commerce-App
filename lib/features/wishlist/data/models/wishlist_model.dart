import 'package:ecommerce_app/features/wishlist/domain/entities/wishlist_entity.dart';

import '../../../product/data/models/product_model.dart';

class WishlistModel extends WishlistEntity{
 const WishlistModel({required super.product});

 Map<String, dynamic> toMap() {
   return {
     'productId': product.productId,
     'productTitle': product.productTitle,
     'productPrice': product.productPrice,
     'productDescription': product.productDescription,
     'productImage': product.productImage,
     'productCategory': product.productCategory,
     'productRating': product.productRating,
   };
 }

 factory WishlistModel.fromMap(Map<String, dynamic> map) {
   return WishlistModel(
     product: ProductModel(
       productId: map['productId'] as int,
       productTitle: map['productTitle'] as String,
       productPrice: (map['productPrice'] as num).toDouble(),
       productDescription: map['productDescription'] as String,
       productImage: map['productImage'] as String,
       productCategory: map['productCategory'] as String,
       productRating: (map['productRating'] as num).toDouble(),
     ),
   );
 }

 factory WishlistModel.fromEntity(WishlistEntity entity){
   return WishlistModel(
     product: entity.product,
   );
 }


}