import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/cart_product/domain/repos/cart_repos.dart';

class GetUserCartCount extends UseCaseWithParams<int, String> {
  const GetUserCartCount(this._repos);

  final CartRepos _repos;
  @override
  ResultFuture<int> call(String params) => _repos.getUserCartCount(params);

}