import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class WishlistEntity extends Equatable {
  final ProductEntity product;
 const WishlistEntity({
    required this.product,
});
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}