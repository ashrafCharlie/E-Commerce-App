import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<void>addItemToCart({
    required String userId,
    required CartItemEntity item,
});

  Stream<List<CartItemEntity>> getCartItems({
    required String userId,
});

  Future<void>updateCartItem({
    required String userId,
    required int productId,
    required int quantity,
});
  Future<void> clearCart({
    required String userId,
});
  Future<void> deleteCartItem({
    required String userId,
    required int productId,
});
}