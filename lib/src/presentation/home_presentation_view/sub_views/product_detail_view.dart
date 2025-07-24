import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/common/widgets/product_detail.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:e_triad/src/cart_product/presentation/provider/cart_provider.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/wishlist_button.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:e_triad/src/reviews/presentation/reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.productId});
  final String productId;
  static const path = '/product-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: context.backgroundColor,
        actions: [
          WishlistButton(productId: productId),
        ],
      ),
      backgroundColor: context.backgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<ProductCubit>()..getProduct(productId),
          ),
          BlocProvider(
            create: (_) => sl<ReviewsCubit>()..getProductReviews(productId),
          ),
          BlocProvider.value(value: sl<CartCubit>()),
        ],
        child: BlocConsumer<CartCubit, CartState>(
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
              _ => null,
            };
          },
          builder: (context, state) {
            return BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return switch (state) {
                  StateFetchedProduct(:final product) =>
                    BlocBuilder<ReviewsCubit, ReviewState>(
                      builder: (context, reviewsState) {
                        final reviews = _getReviewsFromState(reviewsState);

                        return ProductDetailWidget(
                          product: product,
                          productImageUrl: product.productImageUrl,
                          productName: product.productName,
                          productPrice: product.productPrice,
                          ratings: product.ratings?.toInt(),
                          noOfReviews: product.noOfReviews,
                          productDescription: product.productDescription,
                          reviews: reviews,
                          onAddtoCart: () {
                            final userId =
                                UserProvider.instance.currentUser?.id ?? '';
                            context.read<CartCubit>().addToCart(
                             userId: userId,  
                              productId: productId,
                              quantity: 1,
                            selectedSize:   CartProvider.instance.getSelectedSize(product.productId),

                            );
                          },
                        ).loading(
                          isLoading:
                              state is StateProductLoading ||
                              state is StateReviewLoading,
                        );
                      },
                    ),
                  _ =>  Center(child: Container().loading(isLoading: true)),
                };
              },
            );
          },
        ),
      ),
    );
  }

  List<dynamic> _getReviewsFromState(ReviewState state) {
    return switch (state) {
      StateFetchedProductReviews(:final productReviews) =>
        productReviews
            .map(
              (productReview) => (
                userName: productReview.userName,
                userRating: productReview.rating,
                userComment: productReview.comment,
                date: productReview.date,
              ),
            )
            .toList(),
      _ => [],
    };
  }
}
