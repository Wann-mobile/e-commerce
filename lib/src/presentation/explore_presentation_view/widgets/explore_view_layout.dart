import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/presentation/explore_presentation_view/widgets/category_chips.dart';
import 'package:e_triad/src/presentation/explore_presentation_view/widgets/explore_grid_view.dart';
import 'package:flutter/material.dart';

class ExploreViewLayout extends StatelessWidget {
  const ExploreViewLayout({
    super.key,
    required this.categoryList,
    required this.productList,
    required this.isBothloading,
    this.errorMessage,
    this.onRetry,
    required this.isProductLoading,
    required this.isCatLoading,
    this.onCategorySelected,
  });
  final List<dynamic> categoryList;
  final List<dynamic> productList;
  final bool isBothloading;
  final bool isProductLoading;
  final bool isCatLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final Function(String categoryId)? onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (isBothloading) {
      return _buildJointLoadingState(context);
    }
    if (isProductLoading) {
      return _buildProductLoadingState(context);
    }
    if (isCatLoading) {
      return _buildCatLoadingState(context);
    }
    if (errorMessage != null) {
      return _buildErrorState(context);
    }
    if (productList.isEmpty) {
      return _buildEmptyState(context);
    }
    if (categoryList.isNotEmpty && productList.isEmpty) {
      return Column(
        children: [
          CategoryChips(
            categoriesList: categoryList,
            onCategorySelected: onCategorySelected,
          ),
        ],
      );
    }
    return Column(
      children: [
        CategoryChips(
          categoriesList: categoryList,
          onCategorySelected: onCategorySelected,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ExploreGridView(productsList: productList),
          ),
        ),
      ],
    );
  }

  Widget _buildJointLoadingState(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text('     '),
                  selected: false,
                  onSelected: (bool selected) {
                    null;
                  },
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  showCheckmark: false,
                  backgroundColor: Colors.transparent,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.45,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colours.classicAdaptiveBgCardColor(context),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCatLoadingState(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text('     '),
                  selected: false,
                  onSelected: (bool selected) {
                    null;
                  },
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  showCheckmark: false,
                  backgroundColor: Colors.transparent,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductLoadingState(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.45,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colours.classicAdaptiveBgCardColor(context),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? 'Something went wrong',
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        CategoryChips(categoriesList: categoryList),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No Products available',
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
