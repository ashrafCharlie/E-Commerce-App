
import 'package:ecommerce_app/features/order/presentation/bloc/order_state.dart';
import 'package:ecommerce_app/features/order/domain/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent,OrderState>{
  final OrderRepository orderRepository;
  OrderBloc({
    required this.orderRepository,
}): super(OrderInitialState()){
    on<CreateOrderEvent>(_onCreateOrder);
    on<GetOrdersEvent>(_onGetOrders);
  }

  Future<void> _onCreateOrder(
      CreateOrderEvent event,
      Emitter<OrderState> emit,
      ) async {
    emit(OrderLoadingState());
    try{
    await  orderRepository.createOrder(event.order);
    emit(OrderSuccessState());

    }catch(e){
      emit(OrderErrorState(message: e.toString()));
    }
  }


  Future<void> _onGetOrders(
      GetOrdersEvent event,
      Emitter<OrderState> emit,
      ) async {
    emit(OrderLoadingState());
   await emit.forEach(orderRepository.getOrders(event.userId),
        onData: (orders){
      return OrderLoadedState(orders: orders);
        },
      onError: (error, stackTrace) {
        return OrderErrorState(message: error.toString());
      },
        );

  }




}