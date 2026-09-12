import 'package:ecommerce_app/features/category/data/datasource/category_remote_datasource.dart';
import 'package:ecommerce_app/features/category/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource  categoryRemoteDatasource;
  CategoryRepositoryImpl({required this.categoryRemoteDatasource});
  @override
  Future<List<CategoryEntity>> getCategories() async {
    return await categoryRemoteDatasource.getCategories();
  }

}