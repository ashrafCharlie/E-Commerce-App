import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:equatable/equatable.dart';

sealed class CartState extends Equatable{
  @override
  List<Object?> get props => [];
}

class CartInitState extends CartState{}

class CartLoadingState extends CartState{}

class CartLoadedState extends CartState{
  final List<CartItemEntity> cartItems;
  CartLoadedState({required this.cartItems});
  @override
  List<Object?> get props => [cartItems];
}