import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/domain/repo/product_repos.dart';

class GetProduct extends UseCaseWithParams<Product, String> {
  const GetProduct(this._repos);
  final ProductRepos _repos;

  @override
  ResultFuture<Product> call(String params) =>
      _repos.getProduct( params);
}
