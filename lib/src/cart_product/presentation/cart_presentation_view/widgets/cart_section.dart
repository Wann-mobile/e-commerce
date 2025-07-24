import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/cart_product/presentation/cart_presentation_view/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';

class CartItemSection extends StatelessWidget {
  const CartItemSection({
    super.key,
    required this.cartItemList,
    required this.isLoading,
    this.errorMessage,
    this.onRetry,
    this.onRemovePressed,
     this.onQuantityUpdated,
  });
  final List<dynamic> cartItemList;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final Function(dynamic product)? onQuantityUpdated;
  final Function(dynamic cartProductId)? onRemovePressed;
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading){
      return _buildLoadingState(context);
    }
    if(errorMessage != null){
      return _buildErrorState(context);
    }
    if(cartItemList.isEmpty){
      return _buildEmptyState(context);
    }
    return ListView.builder(
      itemCount: cartItemList.length,
      itemBuilder: (context, index) {
        final cartItem = cartItemList[index];
       final cartProductId = cartItem.id;
        return CartItemCard(    
          productName: cartItem.productName,
          productImageUrl: cartItem.productImage,
          productPrice: cartItem.productPrice,
          productSize: cartItem.selectedSize,
          cartProductId: cartItem.id,
          quantity: cartItem.quantity ?? 1,
          onRemovePressed:() { 
             cartItemList.removeAt(index);
            onRemovePressed?.call(cartProductId); 
            }
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
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
            'No Products added to cart',
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
