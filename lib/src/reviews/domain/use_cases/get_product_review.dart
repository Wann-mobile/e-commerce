import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/reviews/domain/entity/reviews.dart';
import 'package:e_triad/src/reviews/domain/repos/review_repos.dart';
import 'package:equatable/equatable.dart';

class GetProductReviews extends UseCaseWithParams<List<Reviews>, GetProductReviewsParams> {
  const GetProductReviews(this._repos);
  
  final ReviewRepos _repos;
  
  @override
  ResultFuture<List<Reviews>> call(GetProductReviewsParams params) =>
      _repos.getProductReviews(params.productId, page: params.page);
}

class GetProductReviewsParams extends Equatable {
  const GetProductReviewsParams({required this.productId, required this.page });
  
  final String productId;
  final int page;
  
  @override
  List<Object> get props => [productId, page];
}