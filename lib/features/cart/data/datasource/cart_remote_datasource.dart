import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';

import '../../domain/entities/cart_item_entity.dart';

abstract class CartRemoteDatasource {
  Future<void>addToCart( {required String userId,required CartModel item});
  Stream<List<CartModel>> getCartItems({required String userId});

  Future<void>updateCartItem({
    required String userId,
    required int productId,
    required int quantity,
});
  Future<void> deleteCartItem(String userId, int productId);
  Future<void> clearCart({required String userId});

}