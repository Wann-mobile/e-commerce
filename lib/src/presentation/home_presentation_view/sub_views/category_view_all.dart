import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/src/categories/presentation/categories_cubit.dart';
import 'package:e_triad/src/categories/presentation/category_grid_detail_view.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/vertical_list_views/cat_vert_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoryViewAll extends StatefulWidget {
  const CategoryViewAll({super.key});

  static const path = '/category-view-all';

  @override
  State<CategoryViewAll> createState() => _CategoryViewAllState();
}

class _CategoryViewAllState extends State<CategoryViewAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      backgroundColor: context.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: BlocBuilder<CategoryCubit, CategoryState>(
        
          builder: (context, state) {
            return switch (state) {
              StateFetchedCategories(:final categoriesList) => CatVertList(
                categoryList: categoriesList,
                onCategoryTap: (category) {
                 
               context.push(CategoryGridDetailView.path,extra: category,);
                },
              ),
              StateGettingCategory() => CatVertList(
                categoryList: [],
                isLoading: true,
              ),
              ErrorCategoryState(:final message) => CatVertList(
                categoryList: [],
                errorMessage: message,
                onRetry:
                    () => context.read<CategoryCubit>().fetchCategories(),
              ),
              _ => const CatVertList(categoryList: []),
            };
          },
        ),
      ),
    );
  }
}
