import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:equatable/equatable.dart';

sealed class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddItemToCartEvent extends CartEvent{
  final CartItemEntity cartItem;
  AddItemToCartEvent({required this.cartItem});
   @override
  // TODO: implement props
  List<Object?> get props => [cartItem];
}

class GetCartItemsEvent extends CartEvent{}

class UpdateQuantityEvent extends CartEvent{
  final int productId;
  final int quantity;
  
  UpdateQuantityEvent({
    required this.productId,
    required this.quantity,
  });

   @override
  List<Object?> get props => [productId,quantity];
}