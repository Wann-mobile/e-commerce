import 'package:e_triad/src/categories/presentation/categories_cubit.dart';
import 'package:e_triad/src/presentation/explore_presentation_view/widgets/explore_view_layout.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key, });
  static const path = '/explore';

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryState = context.read<CategoryCubit>().state;
      if (categoryState is! StateFetchedCategories) {
        context.read<CategoryCubit>().fetchCategories();
      } else {
       _handleInitialCategory(categoryState.categoriesList);
      }
    });
  }
void _handleInitialCategory (List<dynamic> categories){

  final productCubit = context.read<ProductCubit>(); 
    if(categories.isNotEmpty){
      final productState = productCubit.state;
      if(productState is StateInitialProduct){
        context.read<ProductCubit>().getProductsByCategory(categories.first.id);
      }
    
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<CategoryCubit, CategoryState>(
            listenWhen: (previous, current) {
              return previous is StateGettingCategory &&
                  current is StateFetchedCategories;
            },
            listener: (context, categoryState) {
              if (categoryState is StateFetchedCategories &&
                  categoryState.categoriesList.isNotEmpty) {
                final productState = context.read<ProductCubit>().state;

                if (productState is StateInitialProduct) {
                  context.read<ProductCubit>().getProductsByCategory(
                    categoryState.categoriesList.first.id,
                  );
                }
              }
            },
          ),
        
        ],
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, categoryState) {
            return BlocBuilder<ProductCubit, ProductState>(
              builder: (context, productState) {
                    return switch ((categoryState, productState)) {          
                      (
                        StateFetchedCategories categoryData,
                        StateFetchedProductByCategory productData,
                      ) =>
                        _buildLayout(
                          categoryList: categoryData.categoriesList,
                          productList: productData.productList,
                         
                          onCategorySelected: (categoryId) {
                            context.read<ProductCubit>().getProductsByCategory(
                              categoryId,
                            );
                          },
                        ),

                      (StateGettingCategory(), StateProductLoading()) =>
                        _buildLayout(isBothloading: true),
                      (
                        StateFetchedCategories categoryData,
                        StateProductLoading(),
                      ) =>
                        _buildLayout(
                          categoryList: categoryData.categoriesList,
                          isProductLoading: true,
                          onCategorySelected: (categoryId) {
                            context.read<ProductCubit>().getProductsByCategory(
                              categoryId,
                            );
                          },
                        ),

                      (
                        StateGettingCategory(),
                        StateFetchedProductByCategory productData,
                      ) =>
                        _buildLayout(
                          productList: productData.productList,
                          isCatLoading: true,
                        ),

                      (
                        ErrorCategoryState categoryError,
                        StateProductError productError,
                      ) =>
                        _buildLayout(
                          errorMessage:
                              '${categoryError.message} and ${productError.message}',
                          onRetry: () {
                            context.read<CategoryCubit>().fetchCategories();
                          },
                        ),

                      (
                        ErrorCategoryState categoryError,
                        StateFetchedProductByCategory productData,
                      ) =>
                        _buildLayout(
                          productList: productData.productList,
                          errorMessage: categoryError.message,
                          onRetry: () {
                            context.read<CategoryCubit>().fetchCategories();
                          },
                        ),

                      (
                        StateFetchedCategories categoryData,
                        StateProductError productError,
                      ) =>
                        _buildLayout(
                          categoryList: categoryData.categoriesList,
                          errorMessage: productError.message,
                          onRetry: () {
                            if (categoryData.categoriesList.isNotEmpty) {
                              context
                                  .read<ProductCubit>()
                                  .getProductsByCategory(
                                    categoryData.categoriesList.first.id,
                                  );
                            }
                          },
                          onCategorySelected: (categoryId) {
                            context.read<ProductCubit>().getProductsByCategory(
                              categoryId,
                            );
                          },
                        ),

                      (
                        ErrorCategoryState categoryError,
                        StateProductLoading(),
                      ) =>
                        _buildLayout(
                          isProductLoading: true,
                          errorMessage: categoryError.message,
                          onRetry: () {
                            context.read<CategoryCubit>().fetchCategories();
                          },
                        ),

                      (
                        StateGettingCategory(),
                        StateProductError productError,
                      ) =>
                        _buildLayout(
                          isCatLoading: true,
                          errorMessage: productError.message,
                          onRetry: () {
                            context.read<CategoryCubit>().fetchCategories();
                          },
                        ),

                      (
                        StateFetchedCategories categoryData,
                        StateInitialProduct(),
                      ) =>
                        _buildLayout(
                          categoryList: categoryData.categoriesList,
                          isProductLoading: true,
                          onCategorySelected: (categoryId) {
                            context.read<ProductCubit>().getProductsByCategory(
                              categoryId,
                            );
                          },
                        ),

                      (StateFetchedCategories categoryData, _) => _buildLayout(
                        categoryList: categoryData.categoriesList,
                        onCategorySelected: (categoryId) {
                          context.read<ProductCubit>().getProductsByCategory(
                            categoryId,
                          );
                        },
                      ),

                      // Default loading state
                      _ => _buildLayout(isBothloading: true),
                    };
              } 
                );
              },
            )
      
          
        ),
      );
    
  }

  Widget _buildLayout({
    List<dynamic> categoryList = const [],
    List<dynamic> productList = const [],
    bool isBothloading = false,
    bool isProductLoading = false,
    bool isCatLoading = false,
    String? errorMessage,

    VoidCallback? onRetry,
    Function(String categoryId)? onCategorySelected,
   
  }) {
    return ExploreViewLayout(
      categoryList: categoryList,
      productList: productList,
      isBothloading: isBothloading,
      isProductLoading: isProductLoading,
      isCatLoading: isCatLoading,
      errorMessage: errorMessage,
      onRetry: onRetry,
      onCategorySelected: onCategorySelected,
    
    );
  }
}
