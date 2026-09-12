import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<void> createOrder(OrderEntity order);
  Stream<List<OrderEntity>>  getOrders(String userId);
  Future<void> cancelOrder({required String orderId});

}