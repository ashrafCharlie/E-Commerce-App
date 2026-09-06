import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoriesImpl implements CartRepository{
   final List<CartItemEntity> _cartItems = [];
  @override
  List<CartItemEntity> addToCart(CartItemEntity item) {
      final existingIndex = _cartItems.indexWhere(
      (cartItem) =>
          cartItem.product.productId == item.product.productId,
    );

    if (existingIndex != -1) {
      final existingItem = _cartItems[existingIndex];

      _cartItems[existingIndex] = CartItemEntity(
        product: existingItem.product,
        quantity: existingItem.quantity + item.quantity,
      );
    } else {
      _cartItems.add(item);
    }

    return List.unmodifiable(_cartItems);
  }

  @override
  List<CartItemEntity> getCartItems() {
    return List.unmodifiable(_cartItems);
  }

  @override
List<CartItemEntity> updateCartItemQuantity({
  required int productId,
  required int quantity,
}) {
  final existingIndex = _cartItems.indexWhere(
    (cartItem) => cartItem.product.productId == productId,
  );

  if (existingIndex != -1) {
    final existingItem = _cartItems[existingIndex];

    if (quantity <= 0) {
      _cartItems.removeAt(existingIndex);
    } else {
      _cartItems[existingIndex] = CartItemEntity(
        product: existingItem.product,
        quantity: quantity,
      );
    }
  }

  return List.unmodifiable(_cartItems);
}

}