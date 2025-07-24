import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/reviews/domain/repos/review_repos.dart';
import 'package:equatable/equatable.dart';

class CreateReview extends UseCaseWithParams<DataMap, CreateReviewParams> {
  const CreateReview(this._repos);
  
  final ReviewRepos _repos;
  
  @override
  ResultFuture<DataMap> call(CreateReviewParams params) =>
      _repos.createReview(
        productId: params.productId,
        userId: params.userId,
        reviewContent: params.reviewContent,
        rating: params.rating
      );
}

class CreateReviewParams extends Equatable {
  const CreateReviewParams({
    required this.productId,
    required this.userId,
    required this.reviewContent,
    required this.rating
  });
  
  final String productId;
  final String userId;
  final String reviewContent;
  final double rating;
  
  @override
  List<Object> get props => [productId, userId, reviewContent, rating];
}