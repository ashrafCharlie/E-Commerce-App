import 'package:ecommerce_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String orderId;
  final String userId;
  final String customerName;
  final String  phone;
  final String address;
  final String city;
  final String paymentMethod;
  final double totalPrice;
  final String status;
  final DateTime createdAt;
  final List<CartItemEntity> items;

const  OrderEntity({
    required this.orderId,
    required this.userId,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.city,
    required this.paymentMethod,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.items
});
  @override
  // TODO: implement props
  List<Object?> get props => [orderId,userId,customerName,phone,address,city,paymentMethod,totalPrice,status,createdAt,items];

}