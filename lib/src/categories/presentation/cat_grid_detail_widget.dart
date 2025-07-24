import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/presentation/explore_presentation_view/widgets/product_explore_card.dart';
import 'package:e_triad/src/presentation/home_presentation_view/sub_views/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CatGridDetailWidget extends StatelessWidget {
  const CatGridDetailWidget({
    super.key,
    required this.productsList,
    required this.isProductLoading,
    this.errorMessage,
    this.onRetry,
  });
  final List<dynamic> productsList;
  final bool isProductLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (isProductLoading) {
      return _buildProductLoadingState(context);
    }
    if (errorMessage != null) {
      return _buildErrorState(context);
    }
    if (productsList.isEmpty) {
      _buildEmptyState(context);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.45,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          final product = productsList[index];

          return ProductExploreCard(
            product: product,

            onTap:
                () => context.push(
                  ProductDetailView.path,
                  extra: product.productId,
                ),
          );
        },
      ),
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
