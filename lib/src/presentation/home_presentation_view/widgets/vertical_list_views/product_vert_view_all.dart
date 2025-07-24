import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/core/utils/cart_utils.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:e_triad/src/presentation/home_presentation_view/sub_views/product_detail_view.dart';
import 'package:e_triad/src/presentation/home_presentation_view/widgets/vertical_list_views/product_vert_list.dart';
import 'package:e_triad/src/products/presentation/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductVertViewAll extends StatelessWidget {
  const ProductVertViewAll({
    super.key,
    required this.title,
     
 required this.isFetchPopularProducts,
  });

  final String title;
  final bool isFetchPopularProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      backgroundColor: context.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                final cubit = sl<ProductCubit>()..getPopularProducts();
               
                return cubit;
              },   
            ),
             BlocProvider(create: (context) => sl<NewArrivalsCubit>()..getNewArrivalProducts()),
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
            builder: (context, _) {
            return isFetchPopularProducts ?  BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  return switch (state) {
                    StateFetchedPopularProducts()  => ProductVertList(
                      productList: state.popularProducts,
                      onproductTap:
                          (product) => context.push(
                            ProductDetailView.path,
                            extra: product.productId,
                          ),
                      onAddToCartPressed: (product) {
                        CartUtils.showSizeSelectionWithCallback(
                          context: context,
                          product: product,
                          onSizeSelected: (String selectedSize) {
                            final finalUserId =
                                UserProvider.instance.currentUser?.id ?? '';
                            context.read<CartCubit>().addToCart(
                            userId:   finalUserId,
                            productId:   product.productId,
                            quantity:   1,
                            selectedSize: selectedSize,
                            );
                          },
                        );
                      },
                    ),
                    StateProductLoading() => ProductVertList(
                      productList: [],
                      isLoading: true,
                    ),
                    StateProductError(:final message) => ProductVertList(
                      productList: [],
                      errorMessage: message,
                      onRetry:
                          () =>  context.read<ProductCubit>()..getPopularProducts(),
                    ),
                    _ => ProductVertList(productList: []),
                  };
                },
              ) :
              BlocBuilder<NewArrivalsCubit, ProductState>(builder: (context, newArrivalstate) {
                  return switch (newArrivalstate) {
                
                    StateFetchedNewArrivals() => ProductVertList(
                      productList: newArrivalstate.newArrivals,
                      onproductTap:
                          (product) => context.push(
                            ProductDetailView.path,
                            extra: product.productId,
                          ),
                      onAddToCartPressed: (product) {
                        CartUtils.showSizeSelectionWithCallback(
                          context: context,
                          product: product,
                          onSizeSelected: (String selectedSize) {
                            final finalUserId =
                                UserProvider.instance.currentUser?.id ?? '';
                            context.read<CartCubit>().addToCart(
                            userId:   finalUserId,
                            productId:   product.productId,
                            quantity:   1,
                            selectedSize:   selectedSize,
                            );
                          },
                        );
                      },
                    ),
                    StateProductLoading() => ProductVertList(
                      productList: [],
                      isLoading: true,
                    ),
                    StateProductError(:final message) => ProductVertList(
                      productList: [],
                      errorMessage: message,
                      onRetry:
                          () =>  context.read<NewArrivalsCubit>()..getNewArrivalProducts(),
                    ),
                    _ => ProductVertList(productList: []),
                  };
                },) ;
            },
          ),
        ),
      ),
    );
  }
}
