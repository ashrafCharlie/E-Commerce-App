import 'package:ecommerce_app/core/validators/app_validator.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:ecommerce_app/features/order/presentation/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItemEntity> cartItems;
  final double totalPrice;
  final UserEntity? currentUser;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.currentUser,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  String selectedPaymentMethod = 'cod';

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocListener<OrderBloc,OrderState>(
         listener: (context, state) {
           if(state is OrderSuccessState){
             context.read<CartBloc>().add(ClearCartEvent(userId: widget.currentUser!.uid));
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrdersScreen(),));
           }
         },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  validator: AppValidator.name,
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  validator: AppValidator.phone,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  validator: AppValidator.address,
                  controller: addressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  validator: AppValidator.city,
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City/Area',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...widget.cartItems.map(
                      (cartItem) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          cartItem.product.productImage,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        cartItem.product.productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Quantity: ${cartItem.quantity}',
                      ),
                      trailing: Text(
                        '\$${(cartItem.product.productPrice * cartItem.quantity).toStringAsFixed(2)}',
                      ),
                    );
                  },
                ),

                const Divider(),

                Row(
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
                      '\$${widget.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                RadioGroup<String>(

                  groupValue: selectedPaymentMethod,
                    onChanged: (value){
                    if(value == null) return;
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                }, child: Column(
                  children: [
                    RadioListTile(
                        value:'cod' ,
                      title: Text("Cash on Delivery"),
                      subtitle: Text("Pay when your order arrives"),
                    ),
                  ],
                )),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_fromKey.currentState!.validate()){
                        final authState = context.read<AuthBloc>().state;
                        if(authState is! AuthenticateState){
                          return;
                        }
                       final order = OrderEntity(
                           orderId: DateTime.now().microsecondsSinceEpoch.toString(),
                           userId: authState.user!.uid,
                           customerName: nameController.text,
                           phone: phoneController.text,
                           address: addressController.text,
                           city: cityController.text,
                           paymentMethod: selectedPaymentMethod,
                           totalPrice:widget.totalPrice ,
                           status: 'Pending',
                           createdAt: DateTime.now(),
                           items: widget.cartItems);
                        context.read<OrderBloc>().add(CreateOrderEvent(order: order));
                      }
                    },
                    child: const Text('Place order'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}