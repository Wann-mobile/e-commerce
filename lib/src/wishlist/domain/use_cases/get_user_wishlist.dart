import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/wishlist/domain/entities/wishlist_product.dart';
import 'package:e_triad/src/wishlist/domain/repos/wishlist_repo.dart';

class GetUserWishlist extends UseCaseWithParams<List<Wishlist>,String >{
  const GetUserWishlist(this._repos);

  final WishlistRepo _repos;
  @override
  ResultFuture<List<Wishlist>> call(String params) => _repos.getUserWishlist(params);

}