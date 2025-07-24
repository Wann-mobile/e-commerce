import 'package:dartz/dartz.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/errors/failures.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/reviews/data/data_src/review_remote_data_scr.dart';
import 'package:e_triad/src/reviews/domain/entity/reviews.dart';
import 'package:e_triad/src/reviews/domain/repos/review_repos.dart';

class ReviewRepoImpl implements ReviewRepos {
  const ReviewRepoImpl(this._remoteDataSrc);

  final ReviewRemoteDataSrc _remoteDataSrc;
  @override
  ResultFuture<DataMap> createReview({
    required String productId,
    required String userId,
    required String reviewContent,
    required double rating,
  }) async {
    try {
      final results = await _remoteDataSrc.createReview(
        productId: productId,
        userId: userId,
        reviewContent: reviewContent,
        rating: rating,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

 @override
  ResultFuture<List<Reviews>> getProductReviews(
    String productId, {
    int page = 1,
  }) async {
    try {
      final results = await _remoteDataSrc.getProductReviews(
        productId,
        page: page,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}