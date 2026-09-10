import 'package:ecommerce_app/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:equatable/equatable.dart';

sealed class WishlistState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WishListInitialState extends WishlistState{}

class WishListLoadingState extends WishlistState{}

class WishListLoadedState extends WishlistState{
  final List<WishlistEntity> wishList;
  WishListLoadedState({required this.wishList});
  @override
  // TODO: implement props
  List<Object?> get props => [wishList];
}

class WishListErrorState extends WishlistState{
  final String message;
  WishListErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class WishListAddSuccessState extends WishlistState{}
class WishListRemoveSuccessState extends WishlistState{}

