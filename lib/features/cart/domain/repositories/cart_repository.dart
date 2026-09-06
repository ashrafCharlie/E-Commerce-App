import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  List<CartItemEntity> addToCart(CartItemEntity item);

  List<CartItemEntity>  getCartItems();
   List<CartItemEntity> updateCartItemQuantity({
    required int productId,
    required int quantity,
  });
}