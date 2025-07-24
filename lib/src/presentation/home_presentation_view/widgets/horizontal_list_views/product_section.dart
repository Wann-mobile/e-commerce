import 'package:e_triad/core/common/widgets/products_card.dart';
import 'package:e_triad/core/common/widgets/view_all.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:flutter/material.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final List<dynamic> products;
  final bool isLoading;
  final List<String> wishlistItems;
  final String? errorMessage;
  final VoidCallback? onViewAll;
  final VoidCallback? onRetry;
  final Function(dynamic product)? onWishlistTap;
  final Function(dynamic product)? onProductTap;
  final Function(dynamic product)? onAddToCart;

  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    this.isLoading = false,
    this.wishlistItems = const [],
    this.errorMessage,
    this.onViewAll,
    this.onRetry,
    this.onProductTap,
    this.onAddToCart,
    this.onWishlistTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAll(title: title, onViewAllPressed: onViewAll ?? () {}),
        SizedBox(height: context.height * 0.32, child: _buildContent(context)),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState(context);
    }

    if (errorMessage != null) {
      return _buildErrorState(context);
    }

    if (products.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      itemCount: products.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final product = products[index];
        final isInWishlistBool = wishlistItems.contains(product.productId);
        return ProductCard(
          key: ValueKey(products[index].productId),
          product: product,
          wishlistToogle: isInWishlistBool,
          onWishlistPressed: () => onWishlistTap?.call(product),
          onTap: () => onProductTap?.call(product),
          onAddToCart: () => onAddToCart?.call(product),
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          width: context.mediaQuery.size.width * 0.55,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
          ),
          child: Column(
            children: [
              Container(
                height: context.mediaQuery.size.height * 0.18,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade300,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No products available',
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new products',
            style: context.theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
