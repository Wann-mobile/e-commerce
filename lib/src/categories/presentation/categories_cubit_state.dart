part of 'categories_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

final class StateInitialCategory extends CategoryState{
  const StateInitialCategory();
}

final class StateGettingCategory extends CategoryState {
  const StateGettingCategory();
}

final class StateFetchedCategories extends CategoryState {
  const StateFetchedCategories(this.categoriesList);

  final List<Category> categoriesList;
  @override
  List<Object?> get props => [categoriesList];
}

final class StateFetchedCategory extends CategoryState {
  const StateFetchedCategory(this.category);

  final Category category;

  @override
  List<Object?> get props => [category];
}

final class ErrorCategoryState extends CategoryState {
  const ErrorCategoryState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
