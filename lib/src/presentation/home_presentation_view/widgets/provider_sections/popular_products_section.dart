import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/utils/cart_utils.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:e_triad/src/presentation/home_presentation_view/sub_views/popular_product_view_all.dart';
import 'package:e_triad/src/presentation/home_presentation_view/sub_views/product_detail_view.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/horizontal_list_views/product_section.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:e_triad/src/wishlist/wishlisht_presentation_view/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class PopularProductsSection extends StatefulWidget {
  const PopularProductsSection({super.key});

  @override
  State<PopularProductsSection> createState() => _PopularProductsSectionState();
}

class _PopularProductsSectionState extends State<PopularProductsSection> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getPopularProducts();
  }

  List<String> _getWishlistItems(User user, WishlistState wishlistState) {
    if (wishlistState is StateFetchedUserWishlist) {
      return wishlistState.wishlistProducts
          .map((item) => item.productId)
          .toList();
    }
    return user.wishlist.map((wishlist) => wishlist.productId).toList();
  }

  void _handleAddToCart(BuildContext context, dynamic product, dynamic user) {
    CartUtils.showSizeSelectionWithCallback(
      context: context,
      product: product,
      onSizeSelected: (String selectedSize) {
        final finalUserId = user?.id ?? '';
        context.read<CartCubit>().addToCart(
          userId: finalUserId,
          productId: product.productId,
          quantity: 1,
          selectedSize: selectedSize,
        );
      },
    );
  }

  void _handleWishlistTap(
    BuildContext context,
    dynamic product,
    dynamic user,
    List<String> wishlistItems,
  ) {
    final userId = user?.id ?? '';

    final isInWishlist = wishlistItems.contains(product.productId);

    if (isInWishlist) {
      context.read<WishlistCubit>().removeFromWishlist(
        userId,
        product.productId,
      );
    } else {
      context.read<WishlistCubit>().addToWishlist(userId, product.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = UserProvider.instance.currentUser;
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            return switch (state) {
              StateCartError(:final message) => CoreUtils.showSnackBar(
                context,
                message: message,
              ),
              StateAddedToCart() => CoreUtils.showSnackBar(
                context,
                message: 'Added to cart',
              ),
    
              _ => Container(),
            };
          },
        ),
        BlocListener<WishlistCubit, WishlistState>(
          listener: (context, state) {
            if (state is StateWishlistRemoved) {
              CoreUtils.showSnackBar(
                context,
                message: 'Removed from wishlist',
              );
             
            }
            if (state is StateWishlistAdded) {
              CoreUtils.showSnackBar(context, message: 'Added to wishlist');
             
            }
            if (state is StateWishlistError) {
              CoreUtils.showSnackBar(context, message: state.message);
            }
          },
        ),
      ],
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, productState) {
          return BlocBuilder<WishlistCubit, WishlistState>(
            builder: (context, wishlistState) {
              final wishlistItems = _getWishlistItems(
                user ?? user!,
                wishlistState,
              );
    
              return switch (productState) {
                StateProductLoading() => ProductSection(
                  title: 'Popular Products',
                  products: const [],
                  wishlistItems: [],
                  isLoading: true,
                ),
                StateFetchedPopularProducts(:final popularProducts) =>
                  ProductSection(
                    title: 'Popular Products',
                    products: popularProducts,
    
                    onViewAll: () => context.push(PopularProductViewAll.path),
                    wishlistItems: wishlistItems,
                    onProductTap:
                        (product) => context.push(
                          ProductDetailView.path,
                          extra: product.productId,
                        ),
                    onAddToCart:
                        (product) => _handleAddToCart(context, product, user),
                    onWishlistTap:
                        (product) => _handleWishlistTap(
                          context,
                          product,
                          user,
                          wishlistItems,
                        ),
                  ),
                StateProductError(:final message) => ProductSection(
                  title: 'Popular Products',
                  products: const [],
                  wishlistItems: [],
    
                  errorMessage: message,
                  onRetry:
                      () => context.read<ProductCubit>().getPopularProducts(),
                ),
                _ => ProductSection(
                  title: 'Popular Products',
                  products: const [],
                  wishlistItems: [],
                ),
              };
            },
          );
        },
      ),
    );
  }
}
