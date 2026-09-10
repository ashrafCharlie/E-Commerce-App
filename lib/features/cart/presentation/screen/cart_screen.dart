import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:ecommerce_app/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_state.dart';

class CartScreen extends StatefulWidget {
  final UserEntity? currentUser;
  const CartScreen({super.key,required this.currentUser});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if(authState is AuthenticateState){
      context.read<CartBloc>().add(
        GetCartItemsEvent(userId: authState.user!.uid ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartLoadedState) {
            if (state.cartItems.isEmpty) {
              return const Center(
                child: Text('Your cart is empty'),
              );
            }
            final totalPrice = state.cartItems.fold<double>(0, 
            (sum, item) => sum + (item.product.productPrice * item.quantity),);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = state.cartItems[index];
                  
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 6,),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                cartItem.product.productImage,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              cartItem.product.productTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            subtitle: Text(
                                '\$${cartItem.product.productPrice.toStringAsFixed(2)}',
                              ),
                          
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      UpdateCartEvent(
                                        userId: widget.currentUser!.uid,
                                        productId: cartItem.product.productId,
                                        quantity: cartItem.quantity - 1,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                            
                                Text(
                                  '${cartItem.quantity}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                            
                              IconButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                    UpdateCartEvent(
                                      userId: widget.currentUser!.uid,
                                      productId: cartItem.product.productId,
                                      quantity: cartItem.quantity + 1,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(cartItems:state.cartItems,totalPrice: totalPrice,currentUser: widget.currentUser),));
                    }, child: Text("Checkout",)),
                  ),
                )
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}