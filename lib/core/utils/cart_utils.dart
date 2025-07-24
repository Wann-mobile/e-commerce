import 'package:flutter/material.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/show_selection.dart';

class CartUtils {
  CartUtils._();

  static void showSizeSelectionWithCallback({
    required BuildContext context,
    required dynamic product,
    required Function(String selectedSize) onSizeSelected,
  }) {
    SizeSelectionModal.show(
      context: context,
      product: product,
      onSizeSelected: onSizeSelected,
    );
  }

 
}
