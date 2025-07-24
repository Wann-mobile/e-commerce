import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/domain/entity/cart_product.dart';

abstract class CartRepos {
  const CartRepos();

  ResultFuture<List<CartProduct>> getUserCart(String userId);
  ResultFuture<int> getUserCartCount(String userId);
  ResultFuture<CartProduct> getCartProductById(
    String cartProductId,
    String userId,
  );
  ResultFuture<void> addToCart(
    String productId,
    String userId,
    int? quantity,
    String selectedSize,
  );
  ResultFuture<CartProduct> updateProductQuantity(
    String cartProductId,
    String userId,
    int quantity,
  );
  ResultFuture<void> removeProductFromCart(String cartProductId, String userId);
}
