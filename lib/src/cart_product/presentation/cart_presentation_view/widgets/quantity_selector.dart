import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/extension/context_ext.dart';

import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/utils/core_utils.dart';

import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.onRemovePressed,
    required this.cartProductId,
    required this.initialQuantity,
  });

  final VoidCallback onRemovePressed;
  final String cartProductId;
  final int initialQuantity;

  @override
  Widget build(BuildContext context) {
    final user = UserProvider.instance.currentUser;

    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is StateUpdatedQuantity) {
          debugPrint('state is $state');
          CoreUtils.showSnackBar(
            context,
            message: 'Cart Successfully Updated',
          );
        }
      },
      builder: (context, cartState) {
        final isUpdating = cartState is StateCartUpdating;
    
        return BlocBuilder<QuantityCubit, int>(
          builder: (context, quantity) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton.filledTonal(
                  onPressed:
                      isUpdating
                          ? null
                          : () {
                            final nextQuantity =
                                quantity > 1 ? quantity - 1 : 1;
                            context.read<QuantityCubit>().decrement();
                            context.read<CartCubit>().updateProductQuantity(
                              user?.id ?? '',
                              cartProductId,
                              nextQuantity,
                            );
                            
                          },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(11, 10)),
                    backgroundColor: WidgetStateProperty.all(
                      context.circlebgColor,
                    ),
                  ),
                  icon: const Icon(Icons.remove),
                  iconSize: 20,
                ),
                const Gap(8),
                Text(
                  '$quantity',
                  style: context.theme.textTheme.bodyLarge!.copyWith(
                    color: context.textColor,
                  ),
                ),
                const Gap(8),
                IconButton.filledTonal(
                  onPressed:
                      isUpdating
                          ? null
                          : () {
                            final nextQuantity = quantity + 1;
                            context.read<QuantityCubit>().increment();
                            context.read<CartCubit>().updateProductQuantity(
                              user?.id ?? '',
                              cartProductId,
                              nextQuantity,
                            );
                          },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(11, 10)),
                    backgroundColor: WidgetStateProperty.all(
                      context.circlebgColor,
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  iconSize: 20,
                ),
                SizedBox(width: context.width * 0.11),
                IconButton(
                  onPressed: isUpdating ? null : onRemovePressed,
                  icon: Icon(
                    IconlyBroken.delete,
                    color: Colours.classicAdaptiveButtonOrIconColor(context),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
