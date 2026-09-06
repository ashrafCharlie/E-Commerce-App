import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
    final CartRepository repo;
    CartBloc({required this.repo}):super(CartInitState()){
        on<AddItemToCartEvent>((event, emit) {
          emit(CartLoadingState());
         final cartItems =  repo.addToCart(event.cartItem);
         emit(CartLoadedState(cartItems: cartItems));
        },);

        on<GetCartItemsEvent>((event, emit) {
          emit(CartLoadingState());
          final cartItems = repo.getCartItems();
          emit(CartLoadedState(cartItems: cartItems));

        },);

        on<UpdateQuantityEvent>((event, emit) {
          emit(CartLoadingState());
        final cartItems =   repo.updateCartItemQuantity(productId: event.productId, quantity: event.quantity);
        emit(CartLoadedState(cartItems: cartItems));
        },);
    }
}