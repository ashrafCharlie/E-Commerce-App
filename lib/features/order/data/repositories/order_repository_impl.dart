import 'package:ecommerce_app/features/order/data/datasource/remote_datasource.dart';
import 'package:ecommerce_app/features/order/data/models/order_model.dart';
import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';
import 'package:ecommerce_app/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository{
  final OrderRemoteDatasource remoteDatasource;
  OrderRepositoryImpl({required this.remoteDatasource});
  @override
  Future<void> createOrder(OrderEntity order) async {
    final orderModel = OrderModel.fromEntity(order);
   await remoteDatasource.createOrder(orderModel);
  }
  @override
  Stream<List<OrderEntity>> getOrders(String userId) {
   return  remoteDatasource.getOrders(userId);
  }

}