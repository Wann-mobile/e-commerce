import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';

class WishlistUtils {
  const WishlistUtils._();
  static bool isProductInWishlist(String productId) {
    return UserProvider.instance.currentUser?.wishlist.any(
          (item) => item.productId == productId,
        ) ??
        false;
  }
}