import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';

class CartModel extends CartItemEntity {
  const CartModel({
    required super.product,
    required super.quantity,
  });

  factory CartModel.fromEntity(CartItemEntity entity) {
    return CartModel(
      product: entity.product,
      quantity: entity.quantity,
    );
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      product: ProductModel(
        productId: map['productId'] as int,
        productTitle: map['productTitle'] as String,
        productPrice: (map['productPrice'] as num).toDouble(),
        productDescription: map['productDescription'] as String,
        productImage: map['productImage'] as String,
        productCategory: map['productCategory'] as String,
        productRating: (map['productRating'] as num).toDouble(),
      ),
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': product.productId,
      'productTitle': product.productTitle,
      'productPrice': product.productPrice,
      'productDescription': product.productDescription,
      'productImage': product.productImage,
      'productCategory': product.productCategory,
      'productRating': product.productRating,
      'quantity': quantity,
    };
  }
}