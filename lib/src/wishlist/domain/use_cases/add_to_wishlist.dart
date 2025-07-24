import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/wishlist/domain/repos/wishlist_repo.dart';
import 'package:equatable/equatable.dart';

class AddToWishlist extends UseCaseWithParams<void, AddToWishlistParams> {
  const AddToWishlist(this._repos);

  final WishlistRepo _repos;

  @override
  ResultFuture<void> call(AddToWishlistParams params) =>
      _repos.addToWishlist(userId: params.userId, productId: params.productId);
}

class AddToWishlistParams extends Equatable {
  const AddToWishlistParams(this.userId, this.productId);

  final String userId;
  final String productId;

  @override
   List<Object?> get props => [userId, productId];
}
