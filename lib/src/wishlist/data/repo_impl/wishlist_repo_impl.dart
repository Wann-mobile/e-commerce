import 'package:dartz/dartz.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/errors/failures.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/wishlist/data/data_src/wishlist_remote_data_src.dart';
import 'package:e_triad/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:e_triad/src/wishlist/domain/repos/wishlist_repo.dart';

class WishlistRepoImpl implements WishlistRepo {
  const WishlistRepoImpl(this._remoteDataSrc);

  final WishlistRemoteDataSrc _remoteDataSrc;
  @override
  ResultFuture<void> addToWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
       await _remoteDataSrc.addToWishlist(
        userId: userId,
        productId: productId,
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Wishlist>> getUserWishlist(String userId) async {
    try {
      final results = await _remoteDataSrc.getUserWishlist(userId);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> removeWishlist({
    required String userId,
    required String productId,
  }) async {
    try {
     await _remoteDataSrc.removeWishlist(
        userId: userId,
        productId: productId,
      );
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
