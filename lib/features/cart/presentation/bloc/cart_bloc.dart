import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
    final CartRepository cartRepository;
    CartBloc({required this.cartRepository}):super(CartInitState()){
        on<AddItemToCartEvent>((event, emit) async {
          emit(CartLoadingState());
        try{
        await  cartRepository.addItemToCart(userId: event.userId, item: event.cartItem);
        emit(CartAddSuccessfulState());
        }catch(e){
          emit(CartErrorState(message: e.toString()));
        }
        },);

        on<GetCartItemsEvent>((event, emit) async {
          emit(CartLoadingState());
        await  emit.forEach(cartRepository.getCartItems(userId: event.userId),
              onData: (item) {
                return CartLoadedState(cartItems: item);
              },
            onError: (error, stackTrace) => CartErrorState(message: error.toString()),
          );

        },);

        on<UpdateCartEvent>((event, emit)  async {
          emit(CartLoadingState());
          try{
            await cartRepository.updateCartItem(userId: event.userId, productId: event.productId, quantity: event.quantity);
          }catch(e){
            emit(CartErrorState(message: e.toString()));
          }

        },);

        on<ClearCartEvent>((event, emit) async {
          emit(CartLoadingState());
          try{
          await  cartRepository.clearCart(userId: event.userId);
          }catch(e){
            emit(CartErrorState(message: e.toString()));
          }
        },);

        on<DeleteCarItemEvent>((event, emit) async {
          emit(CartLoadingState());
          try{
          await  cartRepository.deleteCartItem(userId: event.userId, productId: event.productId);
          }catch(e){
            emit(CartErrorState(message: e.toString()));
          }
        },);
    }
}