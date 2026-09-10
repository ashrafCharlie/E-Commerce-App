import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:equatable/equatable.dart';

sealed class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddItemToCartEvent extends CartEvent{
  final String userId;
  final CartItemEntity cartItem;
  AddItemToCartEvent({required this.cartItem, required this.userId});
   @override
  // TODO: implement props
  List<Object?> get props => [cartItem,userId];
}

class GetCartItemsEvent extends CartEvent{
  final String userId;
  GetCartItemsEvent({
    required this.userId
});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class UpdateCartEvent extends CartEvent{
  final String userId;
  final int productId;
  final int quantity;

  UpdateCartEvent({
    required this.userId,
    required this.productId,
    required this.quantity,
  });

   @override
  List<Object?> get props => [productId,quantity,userId];
}

class DeleteCarItemEvent extends CartEvent{
  final String userId;
  final int productId;
  DeleteCarItemEvent({
    required this.userId,
    required this.productId,
});
  @override
  // TODO: implement props
  List<Object?> get props => [userId,productId];
}


class ClearCartEvent extends CartEvent{
  final String userId;
  ClearCartEvent({
    required this.userId,
});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}