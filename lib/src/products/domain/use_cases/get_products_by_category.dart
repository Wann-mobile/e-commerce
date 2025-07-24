import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/domain/repo/product_repos.dart';
import 'package:equatable/equatable.dart';

class GetProductsByCategory
    extends UseCaseWithParams<List<Product>, GetProductsByCategoryParams> {
  const GetProductsByCategory(this._repos);

  final ProductRepos _repos;

  @override
  ResultFuture<List<Product>> call(GetProductsByCategoryParams params) => _repos
      .getProductsByCategory(category: params.categoryId, page: params.page);
}

class GetProductsByCategoryParams extends Equatable {
  const GetProductsByCategoryParams({
    required this.categoryId,
    required this.page,
  });

  final String categoryId;
  final int page;

  @override
  List<Object> get props => [categoryId, page];
}
