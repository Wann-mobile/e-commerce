import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:e_triad/src/cart_product/presentation/cart_presentation_view/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.productImageUrl,
    required this.productName,
    required this.productSize,
    required this.productPrice,
    required this.cartProductId,
    this.onRemovePressed,
    required this.quantity,
  });

  final String productImageUrl;
  final String productName;
  final String productSize;
  final double productPrice;
  final String cartProductId;
  final int quantity;
  final VoidCallback? onRemovePressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      color: Colours.classicAdaptiveBgCardColor(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildCartImage(context, productImageUrl),
            Gap(8),
            _buildCartItemInfo(
              context,
              productName,
              productPrice,
              productSize,
              onRemovePressed ?? () {},
              cartProductId,
              quantity,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCartItemInfo(
  BuildContext context,
  String productName,
  double productPrice,
  String productSize,
  VoidCallback onRemovePressed,
  String cartProductId,
  int quantity,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        productName,
        style: context.theme.textTheme.bodyLarge!.copyWith(
          color: context.textColor,
        ),
      ),

      Text(
        'NGN ${productPrice.toInt()}',
        style: context.theme.textTheme.bodyMedium!.copyWith(
          color: Colours.classicAdaptiveButtonOrIconColor(context),
        ),
      ),
      Text(
        'Size: $productSize',
        style: context.theme.textTheme.bodySmall!.copyWith(
          color: context.textColor,
        ),
      ),
      Gap(10),
      BlocProvider(
        create: (context) => QuantityCubit(initialQuantity: quantity),
        child: QuantitySelector(
          onRemovePressed: onRemovePressed,
          cartProductId: cartProductId,
          initialQuantity: quantity,
        ),
      ),
    ],
  );
}

Widget _buildCartImage(BuildContext context, String productImageUrl) {
  return Container(
    width: context.width * 0.28,
    height: context.height * 0.15,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.shade100,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        productImageUrl,

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
