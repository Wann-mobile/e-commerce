

part of 'reviews_cubit.dart';
sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

final class StateReviewLoading extends ReviewState {
  const StateReviewLoading();
}

final class StateReviewCreated extends ReviewState {
  const StateReviewCreated(this.review);

  final DataMap review;

  @override
  List<Object?> get props => [review];
}

final class StateFetchedProductReviews extends ReviewState {
  const StateFetchedProductReviews(this.productReviews);

  final List<Reviews> productReviews;

  @override
  List<Object?> get props => [productReviews];
}
final class StateReviewError extends ReviewState {
  const StateReviewError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}