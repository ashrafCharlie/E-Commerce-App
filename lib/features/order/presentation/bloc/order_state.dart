import 'package:ecommerce_app/features/order/domain/entities/order_entity.dart';
import 'package:equatable/equatable.dart';

sealed class OrderState extends Equatable{
  @override
  List<Object?> get props => [];
}

class OrderInitialState extends OrderState{}

class OrderLoadingState extends OrderState{}

class OrderSuccessState extends OrderState{}

class OrderErrorState extends OrderState{
  final String message;
  OrderErrorState({
    required this.message,
});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class OrderLoadedState  extends OrderState{
  final List<OrderEntity> orders;
  OrderLoadedState({
    required this.orders,
});

  @override
  // TODO: implement props
  List<Object?> get props => [orders];
}

class OrderCancelSuccessfulState extends OrderState{}