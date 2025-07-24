import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/reviews/domain/entity/reviews.dart';

abstract class ReviewRepos {
const ReviewRepos();
 
  ResultFuture<List<Reviews>> getProductReviews(
    String productId, {
    int page = 1,
  });

  ResultFuture<DataMap> createReview({
    required String productId,
    required String userId,
    required String reviewContent,
    required double rating, 
  });
}