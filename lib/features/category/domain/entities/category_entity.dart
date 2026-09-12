import 'package:equatable/equatable.dart';

class CategoryEntity extends  Equatable {
  final String name;
  final String slug;
  final String url;
  const CategoryEntity({required this.name, required this.slug,required this.url});

  @override
  // TODO: implement props
  List<Object?> get props => [name,slug,url];
}