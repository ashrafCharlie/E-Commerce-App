import 'package:ecommerce_app/features/category/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

sealed class CategoryState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CategoryInitialState extends CategoryState{}

class CategoryLoadingState extends CategoryState{}

class CategoryLoadedState extends CategoryState{
  final List<CategoryEntity> categories;
  CategoryLoadedState({required this.categories});
  @override
  // TODO: implement props
  List<Object?> get props => [categories];

}

class CategoryErrorState extends CategoryState{
  final String message;
  CategoryErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}