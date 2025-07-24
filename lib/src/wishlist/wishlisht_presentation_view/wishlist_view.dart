import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/utils/cart_utils.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:e_triad/src/wishlist/widgets/wishlist_vert_view.dart';
import 'package:e_triad/src/wishlist/wishlisht_presentation_view/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  static const path = '/wishlist';

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  final userId = UserProvider.instance.currentUser?.id ?? '';
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().getUserWishlist(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is StateAddedToCart) {
            CoreUtils.showSnackBar(context, message: 'Added to cart');
          }
          if (state is StateCartError) {
            CoreUtils.showSnackBar(context, message: state.message);
          }
        },
        child: BlocConsumer<WishlistCubit, WishlistState>(
          listener: (context, state) {
            if (state is StateWishlistRemoved) {
              CoreUtils.showSnackBar(context, message: 'Removed from wishlist');

              context.read<WishlistCubit>().getUserWishlist(userId);
            }
          },
          builder: (context, state) {
            return switch (state) {
              StateFetchedUserWishlist(:final wishlistProducts) =>
                WishlistVertViewWidget(
                  wishlistItems: wishlistProducts,
                  isLoading: false,
                  onRemovePressed: (product) {
                    context.read<WishlistCubit>().removeFromWishlist(
                      userId,
                      product.productId,
                    );
                  },
                  onAddToCartPressed: (product) {
                    CartUtils.showSizeSelectionWithCallback(
                      context: context,
                      product: product,
                      onSizeSelected: (String selectedSize) {
                        context.read<CartCubit>().addToCart(
                          userId: userId,
                          productId: product.productId,
                          quantity: 1,
                          selectedSize: selectedSize,
                        );
                      },
                    );
                  },
                ),
              StateWishlistUpdating(:final wishlistProducts) =>
                WishlistVertViewWidget(
                  wishlistItems: wishlistProducts,
                  isLoading: false,
                ),
              StateWishlistLoading() => const WishlistVertViewWidget(
                wishlistItems: [],
                isLoading: true,
              ),

              StateWishlistError(:final message) => WishlistVertViewWidget(
                wishlistItems: [],
                errorMessage: message,
                onRetry:
                    () => context.read<WishlistCubit>().getUserWishlist(userId),
              ),

              // Handle other states or provide a default loading state
              _ => const WishlistVertViewWidget(
                wishlistItems: [],
                isLoading: false,
              ),
            };
          },
        ),
      ),
    );
  }
}
