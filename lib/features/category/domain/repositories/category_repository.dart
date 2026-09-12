import 'package:ecommerce_app/features/category/domain/entities/category_entity.dart';

abstract class  CategoryRepository {
  Future<List<CategoryEntity>>  getCategories();
}