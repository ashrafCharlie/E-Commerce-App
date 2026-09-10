import 'package:ecommerce_app/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:equatable/equatable.dart';

sealed class WishlistEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddWishListEvent extends WishlistEvent{
  final String userId;
  final WishlistEntity wishListItem;
  AddWishListEvent({required this.userId,required this.wishListItem});
  @override
  // TODO: implement props
  List<Object?> get props => [userId,wishListItem];
}

class GetWishListEvent  extends WishlistEvent{
  final String userId;
  GetWishListEvent({required this.userId});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class RemoveWishListEvent extends WishlistEvent{
  final String userId;
  final int productId;
  RemoveWishListEvent({required this.userId, required this.productId});
  @override
  // TODO: implement props
  List<Object?> get props => [userId,productId];
}