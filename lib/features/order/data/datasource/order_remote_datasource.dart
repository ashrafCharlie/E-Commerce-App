import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';

import '../models/order_model.dart';

abstract class OrderRemoteDatasource {
  Future<void> createOrder(OrderModel order);
  Stream<List<OrderModel>> getOrders(String userId);
  Future<void> cancelOrder({required String orderId});
}