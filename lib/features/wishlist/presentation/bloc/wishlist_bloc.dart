import 'package:ecommerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:ecommerce_app/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:ecommerce_app/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent,WishlistState>{
  final WishlistRepository wishlistRepository;
  WishlistBloc({required this.wishlistRepository}): super(WishListInitialState()){
    on<AddWishListEvent>(_onAddWishList);
    on<GetWishListEvent>(_onGetWishList);
    on<RemoveWishListEvent>(_onRemoveWishList);
  }

  Future<void> _onAddWishList(
      AddWishListEvent event,
      Emitter<WishlistState> emit,
      ) async{
    emit(WishListLoadingState());
    try{
      await wishlistRepository.addWishlist(userId: event.userId, wishListItem: event.wishListItem);

    }catch(e){
      emit(WishListErrorState(message: e.toString()));
    }

  }

  Future<void> _onGetWishList(
      GetWishListEvent event,
      Emitter<WishlistState> emit,
      ) async {
    emit(WishListLoadingState());
   await emit.forEach(
     wishlistRepository.getWishlist(userId: event.userId),
       onData: (wishList) {
         return WishListLoadedState(wishList:wishList );
       },
     onError: (error, stackTrace) => WishListErrorState(message: error.toString()),
   );
  }

  Future<void> _onRemoveWishList(
      RemoveWishListEvent event,
      Emitter<WishlistState> emit,
      ) async{
    emit(WishListLoadingState());
    try{
      await wishlistRepository.removeWishList(userId: event.userId, productId: event.productId);

    }catch(e){
      emit(WishListErrorState(message: e.toString()));
    }


  }
}