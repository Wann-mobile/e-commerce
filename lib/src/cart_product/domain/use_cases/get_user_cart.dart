import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/domain/entity/cart_product.dart';
import 'package:e_triad/src/cart_product/domain/repos/cart_repos.dart';

class GetUserCart extends UseCaseWithParams<List<CartProduct>, String> {
  const GetUserCart(this._repos);

  final CartRepos _repos;
  @override
  ResultFuture<List<CartProduct>> call(String params) => _repos.getUserCart(params);

}