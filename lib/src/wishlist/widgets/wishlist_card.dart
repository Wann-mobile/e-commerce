import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishlistItemCard extends StatelessWidget {
  final dynamic product;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const WishlistItemCard({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      color: Colours.classicAdaptiveBgCardColor(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image and Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                _buildProductImage(context, product.productImage),
                const SizedBox(width: 16),

                // Product Details
                Expanded(
                  child: _buildProductDetails(
                    context,
                    product.productName,
                    product.productPrice,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            _buildActionButtons(context, onRemove, onAddToCart),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context, String imageUrl) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 80,
              height: 80,
              color: Colors.grey.shade200,
              child: Icon(
                Icons.image_not_supported,
                color: Colors.grey.shade400,
                size: 32,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context, String name, double price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextInfo(
          context,
          name,
          context.theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(8),
        _buildTextInfo(
          context,
          'NGN ${price.toInt()}',
          context.theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: Colours.classicAdaptiveButtonOrIconColor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    VoidCallback onRemove,
    VoidCallback onAddToCart,
  ) {
    return Row(
      children: [
        // Remove Button
        Expanded(
          child: RoundedButton(
            text: 'Remove',
            height: 45,
            // width: 150,
            backgroundColor: Colors.transparent,
            textStyle: context.theme.textTheme.bodyLarge?.copyWith(
              color: Colours.classicAdaptiveButtonOrIconColor(context),
              fontSize: 18,
            ),
            onPressed: onRemove,
          ),
        ),

        const SizedBox(width: 12),

        // Add to Cart Button
        Expanded(
          child: RoundedButton(
            text: 'Add to Cart',
            height: 45,
            // width: 180,
            textStyle: context.theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
            onPressed: onAddToCart,
          ),
        ),
      ],
    );
  }

  Widget _buildTextInfo(
    BuildContext context,
    String text,
    TextStyle? textstyle,
  ) {
    return Text(
      text,
      style: textstyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
