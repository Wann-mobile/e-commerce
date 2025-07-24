import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/wishlist/domain/entities/wishlist_product.dart';

abstract class WishlistRepo {
  const WishlistRepo();

  ResultFuture<List<Wishlist>> getUserWishlist(String userId);
  ResultFuture<void> addToWishlist({
    required String userId,
    required String  productId,
  });
  ResultFuture<void> removeWishlist({
    required String userId,
    required String  productId,
  });
}