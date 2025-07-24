import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/domain/repo/product_repos.dart';
import 'package:equatable/equatable.dart';

class SearchProductsByCategory
    extends UseCaseWithParams<List<Product>, SearchProductsByCategoryParams> {
  const SearchProductsByCategory(this._repos);

  final ProductRepos _repos;

  @override
  ResultFuture<List<Product>> call(SearchProductsByCategoryParams params) =>
      _repos.searchProductsByCategory(
        searchTerm: params.searchTerm,
        category: params.category,
        page: params.page,
      );
}

class SearchProductsByCategoryParams extends Equatable {
  const SearchProductsByCategoryParams({
    required this.searchTerm,
    required this.category,
    required this.page,
  });

  final String searchTerm;
  final String category;
  final int page;

  @override
  List<Object> get props => [searchTerm, category, page];
}
