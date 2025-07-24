// Reusable Product Card Widget
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onAddToCart,
    this.onTap,
    required this.wishlistToogle,
    this.onWishlistPressed,
  });

  final dynamic product;
  final VoidCallback? onAddToCart;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistPressed;
  final bool wishlistToogle;

  @override
  Widget build(BuildContext context) {
    final width = context.width;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.deferToChild,
      child: Container(
        width: width * 0.55,
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colours.classicAdaptiveBgCardColor(context),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildProductImage(context)),
            Expanded(child: _buildProductInfo(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: context.height * 0.15,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
            image: DecorationImage(
              image: NetworkImage(product.productImageUrl),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) {
                debugPrint('Error loading image: $exception');
              },
            ),
          ),
        ),
        Positioned(
          top: context.height * 0.001,
          left: context.height * 0.2,
          child: IconButton(
            onPressed: onWishlistPressed,
            icon: Icon(
              wishlistToogle ? IconlyBold.heart : IconlyBroken.heart,
              color: context.adaptiveColor(
                lightColor: Colours.darkButtonPrimary,
                darkColor: Colours.darkButtonSecondary,
              ),
              size: context.height * 0.035,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  style: context.theme.textTheme.headlineSmall?.copyWith(
                    color: context.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'NGN ${product.productPrice.toInt()}',
                  style: context.theme.textTheme.bodyLarge?.copyWith(
                    color: context.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                _buildRatingWidget(context),
              ],
            ),
          ),
          _buildAddToCartButton(context),
        ],
      ),
    );
  }

  Widget _buildRatingWidget(BuildContext context) {
    return Row(
      children: [
        const Icon(IconlyBold.star, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        Text(
          product.ratings.toString(),
          style: context.theme.textTheme.bodyMedium?.copyWith(
            color: Colours.classicAdaptiveSecondaryTextColor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return IconButton.filledTonal(
      onPressed:
          onAddToCart ??
          () {
            CoreUtils.showSnackBar(
              context,
              message: '${product.productName} added to cart',
            );
          },
      iconSize: context.height * 0.038,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          context.adaptiveColor(
            lightColor: Colours.darkButtonPrimary,
            darkColor: Colours.darkButtonSecondary,
          ),
          // ? Colours.darkButtonPrimary
          // : Colours.darkButtonSecondary,
        ),
      ),
      icon: const Icon(IconlyBold.bag_2, color: Colors.white),
    );
  }
}
