import 'package:ecommerce_app/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoriesImpl implements CartRepository{
  final CartRemoteDatasource remoteDatasource;
  CartRepositoriesImpl({required this.remoteDatasource});
  @override
  Future<void> addItemToCart({required String userId, required CartItemEntity item})  async {
    final cartItem = CartModel.fromEntity(item);
   await remoteDatasource.addToCart(userId: userId, item: cartItem);
  }

  @override
  Future<void> clearCart({required String userId}) async {
   await remoteDatasource.clearCart(userId: userId);
  }

  @override
  Stream<List<CartItemEntity>> getCartItems({required String userId}) {
   return remoteDatasource.getCartItems(userId: userId );
  }

  @override
  Future<void> updateCartItem({required String userId, required int productId, required int quantity}) async {
   await remoteDatasource.updateCartItem(userId: userId, productId: productId, quantity: quantity);
  }

  @override
  Future<void> deleteCartItem({required String userId, required int productId}) async {
  await  remoteDatasource.deleteCartItem(userId, productId);
  }
 
}