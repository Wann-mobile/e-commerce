import 'package:e_triad/src/categories/domain/entities/category.dart';
import 'package:e_triad/src/categories/domain/use_cases/get_categories.dart';
import 'package:e_triad/src/categories/domain/use_cases/get_category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_cubit_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required GetCategories getCategories,
    required GetCategory getCategory,
  }) : _getCategories = getCategories,
       _getCategory = getCategory,

       super(const StateInitialCategory());

  final GetCategories _getCategories;
  final GetCategory _getCategory;


  Future<void> fetchCategories() async {
    if(state is StateFetchedCategories){
      return;
    }
    emit(const StateGettingCategory());
    final result = await  _getCategories();
    result.fold(
      (failure) => emit(ErrorCategoryState(failure.message)),
      (categories) { 
        emit(StateFetchedCategories(categories));}
    );
  }

  Future<void> fetchCategory(String categoryId) async {
    emit(const StateGettingCategory());
    final result = await _getCategory(categoryId);
    result.fold(
      (failure) => emit(ErrorCategoryState(failure.message)),
      (category) => emit(StateFetchedCategory(category)),
    );
  }
}

class IndexCubit extends Cubit<int> {
  IndexCubit({
      int initialIndex = 0,
  }) :super (initialIndex);

  void selectIndex (int index) {
     if(index >= 0 && index != state ){
      emit(index);
     }
     }

     int get selectedIndex => state;
}
