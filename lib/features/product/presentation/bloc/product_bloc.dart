import 'package:ecommerce_app/core/utils/debounce_transformer.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repo.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc  extends Bloc<ProductEvent,ProductState>{
  final ProductRepo productRepo;
  ProductBloc({required  this.productRepo}): super(ProductInitState()){
    on<ProductFetchEvent>((event, emit) async {
      emit(ProductLoadingState());
      try{
     final  productList =  await productRepo.getProducts();
     emit(ProductLoadedState(productList: productList));

      }catch(e){
        emit(ProductErrorState(errorMessage: e.toString()));
      }
    },);

    on<SearchProductEvent>((event, emit) async {
      final searchWord = event.searchWord.trim();
      try {
        if(searchWord.isEmpty){
          final productList = await productRepo.getProducts();
          emit(ProductLoadedState(productList: productList));
          return;
        }
        final productList = await productRepo.searchProducts(
          searchWord: event.searchWord,
        );

        emit(ProductLoadedState(productList: productList));
      } catch (e) {
        emit(ProductErrorState(errorMessage: e.toString()));
      }
    },transformer: debounce(Duration(microseconds: 500)));

    on<GetProductsByCategoryEvent>((event, emit) async {
      emit(ProductLoadingState());
      try{
        final products = await productRepo.getProductByCategory(slug: event.slug);
        emit(ProductLoadedState(productList: products));

      }catch(e){
        emit(ProductErrorState(errorMessage: e.toString()));
      }
    },);
  }
}