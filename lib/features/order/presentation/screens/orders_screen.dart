import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc_state.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if(authState is AuthenticateState){
      final userId =  authState.user!.uid;
      context.read<OrderBloc>().add(GetOrdersEvent(userId: userId));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My orders"),
      ),
      body: BlocBuilder<OrderBloc,OrderState>(
          builder: (context, state) {
            if(state is OrderLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is OrderErrorState){
              return Center(child: Text(state.message),);
            }
            if(state is OrderLoadedState){
              final orders = state.orders;
              if(orders.isEmpty){
                return Center(child: Text("No orders found"),);
              }
              return ListView.builder(
                itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order  = orders[index];
                    return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(

                          title: Text(
                            'Order #${order.orderId}',
                          ),
                          subtitle: Text(
                            '${order.items.length} items\n'
                                'Total: \$${order.totalPrice}',
                          ),
                          trailing: Text(order.status),
                        )
                    );
                  },
              );
            }
            return Center(child: Text("Some error occured"),);
          },
      ),
    );
  }
}
