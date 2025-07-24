import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/reviews/domain/entity/reviews.dart';
import 'package:e_triad/src/reviews/domain/use_cases/create_review.dart';
import 'package:e_triad/src/reviews/domain/use_cases/get_product_review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewState> {
  ReviewsCubit({
    required CreateReview createReview,
    required GetProductReviews getProductReviews,
  }) : _createReview = createReview,
       _getProductReviews = getProductReviews,
       super(const StateReviewLoading());
  final CreateReview _createReview;
  final GetProductReviews _getProductReviews;
  
  Future<void> createReview({
    required String productId,
    required String userId,
    required String reviewContent,
    required double rating,
  }) async {
    emit(const StateReviewLoading());
    final result = await _createReview(
      CreateReviewParams(
        productId: productId,
        userId: userId,
        reviewContent: reviewContent,
        rating: rating,
      ),
    );
    result.fold((failure) => emit(StateReviewError(failure.errorMessage)), (
      review,
    ) {
      emit(StateReviewCreated(review));
    });
  }

  Future<void> getProductReviews(String productId, {int page = 1}) async {
    emit(const StateReviewLoading());
    final result = await _getProductReviews(
      GetProductReviewsParams(productId: productId, page: page),
    );
    result.fold((failure) => emit(StateReviewError(failure.errorMessage)), (
      reviews,
    ) {
      emit(StateFetchedProductReviews(reviews));
    });
  }
}
