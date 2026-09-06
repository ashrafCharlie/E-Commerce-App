import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final ProductEntity product;
  final  int quantity;
 const CartItemEntity({required this.product, required this.quantity});
 
 @override
  // TODO: implement props
  List<Object?> get props => [product,quantity];
  
}