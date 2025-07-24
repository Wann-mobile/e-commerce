import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:e_triad/src/cart_product/presentation/cart_presentation_view/widgets/cart_header.dart';
import 'package:e_triad/src/cart_product/presentation/cart_presentation_view/widgets/cart_section.dart';
import 'package:e_triad/src/checkout/checkout_presentation_view/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  static const path = '/cart';

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final user = UserProvider.instance.currentUser;
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getUserCart(user?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: AppBar(title: Text('My Cart')),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final userCartProduct = state is StateFetchedUserCart
                ? state.cartProducts
                : null;
            int getTotalPrices({required CartState state}) {
              if (state is StateFetchedUserCart) {
                int subtotal = 0;
                for (dynamic cartItem in state.cartProducts) {
                  final productPrice =
                      (cartItem.productPrice.toInt()) *
                      (cartItem.quantity ?? 0);
                  subtotal += productPrice as int;
                }
                return subtotal;
              }
              return 0;
            }
            

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CartHeader(title: 'Cart Summary', content: ''),
                SizedBox(height: 1),
                CartHeader(
                  title: 'Subtotal',
                  content: 'NGN ${getTotalPrices(state: state)}',
                  //
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: switch (state) {
                      StateFetchedUserCart(:final cartProducts) =>
                        CartItemSection(
                          cartItemList: cartProducts,
                          isLoading: false,
                          onRemovePressed: (cartProductId) {
                            context.read<CartCubit>().removeCartProduct(
                              user?.id ?? '',
                              cartProductId,
                            );
                          },
                        ),
                      StateCartLoading() => CartItemSection(
                        cartItemList: [],
                        isLoading: true,
                      ),
                      StateCartUpdating(:final cartProducts) => CartItemSection(
                        cartItemList: cartProducts,
                        isLoading: false,
                        onRemovePressed: (product) {},
                      ),
                      StateCartError(:final message) => CartItemSection(
                        cartItemList: [],
                        isLoading: false,
                        errorMessage: message,
                        onRetry:
                            () => context.read<CartCubit>().getUserCart(
                              user?.id ?? '',
                            ),
                      ),

                      _ => CartItemSection(cartItemList: [], isLoading: false),
                    },
                  ),
                ),
                Center(
                  child: RoundedButton(
                    text: 'Proceed to checkout',
                    textStyle: context.theme.textTheme.bodyLarge!.copyWith(
                      color: context.textColor,
                      fontSize: 18,
                    ),
                    onPressed: () {
                      context.push(CheckoutScreen.path, extra:userCartProduct);
                    },
                    width: context.width * 0.85,
                    height: context.height * 0.075,
                  ),
                ),
                Gap(15),
              ],
            );
          },
        ),
      ),
    );
  }
}
