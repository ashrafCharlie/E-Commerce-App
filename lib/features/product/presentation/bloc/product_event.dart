import 'package:ecommerce_app/features/category/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
   @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductFetchEvent extends ProductEvent{}
class SearchProductEvent extends ProductEvent{
  final String searchWord;
  SearchProductEvent({required this.searchWord});
  @override
  // TODO: implement props
  List<Object?> get props => [searchWord];
}

class GetProductsByCategoryEvent extends ProductEvent{
  final String slug;
  GetProductsByCategoryEvent({required this.slug});
  @override
  // TODO: implement props
  List<Object?> get props => [slug];
}


