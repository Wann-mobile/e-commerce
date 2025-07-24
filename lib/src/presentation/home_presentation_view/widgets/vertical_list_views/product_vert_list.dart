import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/wishlist_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';


class ProductVertList extends StatelessWidget {
  const ProductVertList({
    super.key,
    required this.productList,
    this.onproductTap,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.onWishlistPressed,
    this.onAddToCartPressed,
  });

  final List<dynamic> productList;
  final Function(dynamic product)? onproductTap;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final Function(dynamic product)? onWishlistPressed;
  final Function(dynamic product)? onAddToCartPressed;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState(context);
    }
    if (errorMessage != null) {
      return _buildErrorState(context);
    }
    if (productList.isEmpty) {
      return _buildEmptyState(context);
    }
    return ListView.builder(
      itemCount: productList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final product = productList[index];
        return GestureDetector(
          onTap: () => onproductTap?.call(product),
          child: Container(
            height: context.height * 0.13,
            width: context.width * 0.2,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(bottom: 4),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageInfo(context, index, productList),
                Spacer(),
                _buildProductInfoName(context, index, productList),
                Spacer(),
                _buildActionButtons(context, index),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return ListView.builder(
      itemCount: productList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          height: 90,
          width: 300,
          margin: EdgeInsets.only(bottom: 10),
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
          child: Row(
            children: [
              Container(
                width: 80,
                height: double.maxFinite,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
              ),

              Expanded(child: Center(child: Text(''))),
            ],
          ),
        );
      },
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Products list is not available',
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildImageInfo(BuildContext context, int index, dynamic productList) {
    return Container(
      width: context.width * 0.21,
      height: double.maxFinite,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(productList[index].productImageUrl),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildProductInfoName(
    BuildContext context,
    int index,
    dynamic productList,
  ) {
    return SizedBox(
      height: double.maxFinite,
      width: context.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Text(
            productList[index].productName,
            style: context.theme.textTheme.bodyLarge!.copyWith(
              color: context.textColor,
            ),
          ),
          Text(
            'NGN ${productList[index].productPrice}',
            style: context.theme.textTheme.bodyMedium!.copyWith(
              color: context.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Icon(IconlyBold.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                productList[index].ratings.toString(),
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  color: Colours.classicAdaptiveSecondaryTextColor(context),
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        WishlistButton(
          productId: productList[index].productId,
          iconSize: context.height * 0.04,
        ),

        Gap(5),
        Expanded(
          child: RoundedButton(
            text: 'Add to cart',
            width: context.width * 0.28,
            textStyle: context.theme.textTheme.labelMedium,
            onPressed: () => onAddToCartPressed,
          ),
        ),
      ],
    );
  }
}
