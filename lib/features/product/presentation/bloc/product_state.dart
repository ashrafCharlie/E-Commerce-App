import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

sealed class ProductState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class ProductInitState extends ProductState{}

class ProductLoadingState extends ProductState{}

class ProductLoadedState extends ProductState{
  final List<ProductEntity> productList;
  ProductLoadedState({required this.productList});
  @override
  // TODO: implement props
  List<Object?> get props => [productList];
}

class ProductErrorState extends ProductState{
  final String errorMessage;
  ProductErrorState({required this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}