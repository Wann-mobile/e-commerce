// Reusable Product Card Widget
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/wishlist_button.dart';
import 'package:flutter/material.dart';


class ProductExploreCard extends StatelessWidget {
  const ProductExploreCard({super.key, required this.product, this.onTap});

  final dynamic product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.deferToChild,
      child: Container(
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
          children: [
            _buildProductImage(context),
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
          height: context.height * 0.265,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
            image: DecorationImage(
              image: NetworkImage(product.productImageUrl),
              fit: BoxFit.fitWidth,
              onError: (exception, stackTrace) {
                debugPrint('Error loading image: $exception');
              },
            ),
          ),
        ),
        Positioned(
          top: 3,
          right: 3,
          child: WishlistButton(productId: product.productId)
        ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.productName,

            style: context.theme.textTheme.bodyLarge?.copyWith(
              color: context.textColor,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            product.productDescription,
            style: context.theme.textTheme.bodyLarge!.copyWith(
              color: context.textColor,
            ),
          ),
          const SizedBox(height: 4),

          Text(
            'NGN ${product.productPrice.toInt()}',
            style: context.theme.textTheme.labelLarge?.copyWith(
              color: Colours.classicAdaptiveButtonOrIconColor(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
