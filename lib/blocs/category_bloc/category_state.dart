import 'package:shopme_mobile/blocs/base_bloc.dart';
import 'package:shopme_mobile/data/models/remote/category/category.dart';

abstract class CategoryState extends BaseState {}

class GetCategorySuccessState extends CategoryState {
  final List<Category> categories;

  GetCategorySuccessState({
    this.categories = const [],
  });

  @override
  List<Object?> get props => [categories];
}
