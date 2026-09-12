import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';
import 'package:equatable/equatable.dart';

sealed class OrderEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreateOrderEvent extends OrderEvent{
  final OrderEntity order;
  CreateOrderEvent({
    required this.order,
});
  @override
  // TODO: implement props
  List<Object?> get props => [order];
}


class GetOrdersEvent extends OrderEvent{
  final String userId;
  GetOrdersEvent({
    required  this.userId,
});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class CancelOrderEvent extends OrderEvent{

  final String orderId;
  CancelOrderEvent({required this.orderId});
  @override
  // TODO: implement props
  List<Object?> get props => [orderId];
}
