import 'package:e_triad/src/categories/presentation/categories_cubit.dart';
import 'package:e_triad/src/categories/presentation/category_grid_detail_view.dart';
import 'package:e_triad/src/presentation/home_presentation_view/sub_views/category_view_all.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/horizontal_list_views/category_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategories();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return switch (state) {
          StateFetchedCategories(:final categoriesList) => CategorySection(
            title: 'Categories',
            onViewAll: () => context.push(CategoryViewAll.path),
    
            categoryList: categoriesList,
            isLoading: false,
            onCategoryTap: (category) => context.push(
                  CategoryGridDetailView.path,
                  extra: category,
                ),
          ),
          ErrorCategoryState() => CategorySection(
            title: 'Categories',
            categoryList: [],
            onRetry: () {
              context.read<CategoryCubit>().fetchCategories();
            },
          ),
          StateGettingCategory() => CategorySection(
            title: 'Categories',
            categoryList: [],
            isLoading: true,
          ),
    
         _ => CategorySection(
            title: 'Categories',
            categoryList: [],
            onViewAll: () {},
          ),
        };
      },
    );
  }
}
