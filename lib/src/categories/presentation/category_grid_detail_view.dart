import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/src/categories/presentation/cat_grid_detail_widget.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryGridDetailView extends StatefulWidget {
  const CategoryGridDetailView({super.key, required this.category});
  final dynamic category;
  static const path = '/category-detail-view';
  @override
  State<CategoryGridDetailView> createState() => _CategoryGridDetailViewState();
}

class _CategoryGridDetailViewState extends State<CategoryGridDetailView> {
  @override
  void initState() {
    super.initState();
    //context.read<ProductCubit>().getProductsByCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductCubit>()..getProductsByCategory(widget.category.id),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.category.name)),
        backgroundColor: context.backgroundColor,
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return switch (state) {
              StateFetchedProductByCategory(:final productList) =>
                CatGridDetailWidget(
                  productsList: productList,
                  isProductLoading: false,
                ),
              StateProductLoading() => CatGridDetailWidget(
                productsList: [],
                isProductLoading: true,
              ),
              StateProductError(:final message) => CatGridDetailWidget(
                productsList: [],
                isProductLoading: false,
                errorMessage: message,
              ),
              _ => CatGridDetailWidget(
                productsList: [],
                isProductLoading: true,
              ),
            };
          },
        ),
      ),
    );
  }
}
