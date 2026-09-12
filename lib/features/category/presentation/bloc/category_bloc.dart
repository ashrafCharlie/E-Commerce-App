import 'package:ecommerce_app/features/category/domain/repositories/category_repository.dart';
import 'package:ecommerce_app/features/category/presentation/bloc/category_event.dart';
import 'package:ecommerce_app/features/category/presentation/bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  final CategoryRepository categoryRepository;
  CategoryBloc({required this.categoryRepository}): super(CategoryInitialState()){
    on<GetCategoriesEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try{
       final categories = await categoryRepository.getCategories();
       emit(CategoryLoadedState(categories: categories));

      }catch(e){
        emit(CategoryErrorState(message: e.toString()));
      }
    },);
  }
}