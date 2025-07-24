import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/wishlist/wishlisht_presentation_view/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconly/iconly.dart';

class WishlistButton extends StatelessWidget {
  final String productId;

  final double? iconSize;
  final Color? iconColor;

  WishlistButton({
    super.key,
    required this.productId,

    this.iconSize,
    this.iconColor,
  });

  final user = UserProvider.instance.currentUser;

  List<String> _getWishlistItems(User user, WishlistState wishlistState) {
    if (wishlistState is StateFetchedUserWishlist) {
      return wishlistState.wishlistProducts
          .map((item) => item.productId)
          .toList();
    }
    return user.wishlist.map((wishlist) => wishlist.productId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
     value: context.read<WishlistCubit>()..getUserWishlist(user?.id ?? ''),
      child: BlocConsumer<WishlistCubit, WishlistState>(
        listener: (context, state) {
          if (state is StateWishlistRemoved) {
            CoreUtils.showSnackBar(context, message: 'Removed from wishlist');
            context.read<WishlistCubit>().getUserWishlist(user?.id ?? '');
          }
          if (state is StateWishlistAdded) {
            CoreUtils.showSnackBar(context, message: 'Added to wishlist');
            context.read<WishlistCubit>().getUserWishlist(user?.id ?? '');
          }
          if (state is StateWishlistError) {
            CoreUtils.showSnackBar(context, message: state.message);
          }
        },
        builder: (context, state) {
          final wishlist = _getWishlistItems(user ?? user!, state);
          final isInWishlist = wishlist.contains(productId);
          return IconButton(
            icon: Icon(
              isInWishlist ? IconlyBold.heart : IconlyBroken.heart,
              color:
                  iconColor ??
                  (isInWishlist
                      ? Colours.classicAdaptiveButtonOrIconColor(context)
                      : Colors.grey),
              size: iconSize ?? context.height * 0.035,
            ),
            onPressed: () async {
              final userId = UserProvider.instance.currentUser?.id;
              if (userId == null) {
                CoreUtils.showSnackBar(context, message: 'Please login');
                return;
              }

              if (isInWishlist) {
                await context.read<WishlistCubit>().removeFromWishlist(
                  userId,
                  productId,
                );
              } else {
                await context.read<WishlistCubit>().addToWishlist(
                  userId,
                  productId,
                );
              }
            },
          );
        },
      ),
    );
  }
}
