import 'package:e_triad/core/common/widgets/dynamic_loader.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/src/wishlist/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';

class WishlistVertViewWidget extends StatelessWidget {
  const WishlistVertViewWidget({
    super.key,
    required this.wishlistItems,
    this.onRemovePressed,
    this.onAddToCartPressed,
    this.isLoading = false,
    this.onRetry,
    this.errorMessage,
  });

  final List<dynamic> wishlistItems;
  final bool isLoading;
  final Function(dynamic product)? onRemovePressed;
  final Function(dynamic product)? onAddToCartPressed;
  final VoidCallback? onRetry;
  final String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return _buildloadingState(context);
    }
    if (errorMessage != null) {
      return _buildErrorState(context);
    }
    if (wishlistItems.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        final product = wishlistItems[index];
        return WishlistItemCard(
          product: wishlistItems[index],
          onRemove: () {
            wishlistItems.removeAt(index);
            onRemovePressed?.call(product);
          },
          onAddToCart: () => onAddToCartPressed?.call(product),
        );
      },
    );
  }

  Widget _buildloadingState(BuildContext context) {
    return DynamicLoader(originalWidget: Container(), isLoading: isLoading);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to your wishlist to see them here',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
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
}
