import 'package:dartz/dartz.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/errors/failures.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/data/data_src/cart_product_remote_data_src.dart';
import 'package:e_triad/src/cart_product/domain/entity/cart_product.dart';
import 'package:e_triad/src/cart_product/domain/repos/cart_repos.dart';

class CartProductRepoImpl implements CartRepos {
  const CartProductRepoImpl(this._remoteDataSrc);

  final CartProductRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> addToCart(
    String productId,
    String userId,
    int? quantity,
    String selectedSize,
  ) async {
    try {
       await _remoteDataSrc.addToCart(
        productId,
        userId,
        quantity ?? 1,
        selectedSize,
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CartProduct> getCartProductById(
    String cartProductId,
    String userId,
  ) async {
    try {
      final results = await _remoteDataSrc.getCartProductById(
        cartProductId,
        userId,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<CartProduct>> getUserCart(String userId) async {
    try {
      final results = await _remoteDataSrc.getUserCart(userId);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int> getUserCartCount(String userId) async {
    try {
      final results = await _remoteDataSrc.getUserCartCount(userId);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> removeProductFromCart(
    String cartProductId,
    String userId,
  ) async {
    try {
      await _remoteDataSrc.removeProductFromCart(cartProductId, userId);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CartProduct> updateProductQuantity(
    String cartProductId,
    String userId,
    int quantity,
  ) async {
    try {
      final results = await _remoteDataSrc.updateProductQuantity(
        cartProductId,
        userId,
        quantity
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
