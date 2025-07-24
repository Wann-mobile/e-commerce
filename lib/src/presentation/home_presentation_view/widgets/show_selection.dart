import 'package:e_triad/src/cart_product/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';

class SizeSelectionModal extends StatelessWidget {
  const SizeSelectionModal({
    super.key,
    required this.product,
    required this.onSizeSelected,
  });

  final dynamic product;
  final Function(String size) onSizeSelected;

  static Future<void> show({
    required BuildContext context,
    required dynamic product,
    required Function(String size) onSizeSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder:
          (context) => SizeSelectionModal(
            product: product,
            onSizeSelected: onSizeSelected,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: context.width * 0.4,
                height: context.height * 0.004,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.productImageUrl ?? '',
                    width: context.width * 0.20,
                    height: context.height * 0.07,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName ?? 'Product',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(4),
                      Text(
                        'NGN ${product.productPrice ?? 0}',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colours.classicAdaptiveButtonOrIconColor(
                            context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(24),

            // Size selector with auto-close functionality
            ProductSizeSelectorForModal(
              product: product,
              onSizeSelected: (size) {
                // Close modal and call the callback
                Navigator.of(context).pop();
                onSizeSelected(size);
              },
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

// Alternative Dialog version
class SizeSelectionDialog extends StatelessWidget {
  const SizeSelectionDialog({
    super.key,
    required this.product,
    required this.onSizeSelected,
  });

  final dynamic product;
  final Function(String size) onSizeSelected;

  static Future<void> show({
    required BuildContext context,
    required dynamic product,
    required Function(String size) onSizeSelected,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true, // Allow tap outside to dismiss
      builder:
          (context) => SizeSelectionDialog(
            product: product,
            onSizeSelected: onSizeSelected,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Select Size',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),

            // Product info
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.productImageUrl ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName ?? 'Product',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(4),
                      Text(
                        'NGN ${product.productPrice ?? 0}',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colours.classicAdaptiveButtonOrIconColor(
                            context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(20),

            // Size selector with auto-close functionality
            ProductSizeSelectorForModal(
              product: product,
              onSizeSelected: (size) {
                // Close dialog and call the callback
                Navigator.of(context).pop();
                onSizeSelected(size);
              },
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}

// Modified version of your ProductSizeSelector for the modal
class ProductSizeSelectorForModal extends StatefulWidget {
  const ProductSizeSelectorForModal({
    super.key,
    required this.product,
    required this.onSizeSelected,
  });

  final dynamic product;
  final Function(String size) onSizeSelected;

  @override
  State<ProductSizeSelectorForModal> createState() =>
      _ProductSizeSelectorForModalState();
}

class _ProductSizeSelectorForModalState
    extends State<ProductSizeSelectorForModal> {
  int selectedIndex = 0;
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  late final dynamic product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(12),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });

                    // Set the selected size in your provider
                    CartProvider.instance.setSelectedSize(
                      product.productId,
                      sizes[index],
                    );

                    // Automatically call the callback with selected size after a short delay
                    Future.delayed(const Duration(milliseconds: 300), () {
                      widget.onSizeSelected(sizes[index]);
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colours.classicAdaptiveButtonOrIconColor(
                                context,
                              )
                              : context.adaptiveColor(
                                lightColor: Colors.grey.shade200,
                                darkColor: Colors.grey.shade600,
                              ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        sizes[index],
                        style: context.textTheme.titleMedium?.copyWith(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
