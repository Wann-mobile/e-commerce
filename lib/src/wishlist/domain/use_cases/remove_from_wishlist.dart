import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/wishlist/domain/repos/wishlist_repo.dart';
import 'package:equatable/equatable.dart';

class RemoveFromWishlist extends UseCaseWithParams<void, RemoveFromWishlistParams> {
  const RemoveFromWishlist(this._repos);

  final WishlistRepo _repos;

  @override
  ResultFuture<void> call(RemoveFromWishlistParams params) =>
      _repos.removeWishlist(userId: params.userId, productId: params.productId);
}

class RemoveFromWishlistParams extends Equatable {
  const RemoveFromWishlistParams(this.userId, this.productId);

  final String userId;
  final String productId;

  @override
  List<Object?> get props => [userId, productId];
}
