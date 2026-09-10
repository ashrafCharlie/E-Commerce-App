import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order #${order.orderId}'),
                    SizedBox(height: 8.0,),
                    Text("Status: ${order.status}"),
                    Text("Date: ${order.createdAt}"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0,),

            Text('Customer Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8.0,),

            Card(
              child: Padding(padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Name: ${order.customerName}'),
                  Text('Phone: ${order.phone}'),
                  Text('Address: ${order.address}'),
                  Text('City: ${order.city}'),
                ],
              ),),
            ),
            const SizedBox(height: 20),

            const Text(
              'Ordered Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Column(
              children: order.items.map((item) {
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      item.product.productImage,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item.product.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'Qty: ${item.quantity} × '
                          '\$${item.product.productPrice}',
                    ),
                    trailing: Text(
                      '\$${item.product.productPrice * item.quantity}',
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            const Text(
              'Payment Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: ListTile(
                title: const Text('Payment Method'),
                trailing: Text(order.paymentMethod == 'cod'? "Cash on Delivery": 'Online Payment'),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),
                        Text('\$${order.totalPrice}'),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery Fee'),
                        Text('\$0'),
                      ],
                    ),

                    const Divider(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${order.totalPrice}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
