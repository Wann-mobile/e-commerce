import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/domain/repo/product_repos.dart';

class GetNewArrivalProducts extends UseCaseWithParams<List<Product>, int> {
  const GetNewArrivalProducts(this._repos);
  
  final ProductRepos _repos;
  
  @override
  ResultFuture<List<Product>> call(int params) =>
      _repos.getNewArrivalProducts(page: params);
}

