import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/domain/repo/product_repos.dart';
import 'package:equatable/equatable.dart';

class SearchAllProducts
    extends UseCaseWithParams<List<Product>, SearchAllProductParams> {
  const SearchAllProducts(this._repos);

  final ProductRepos _repos;

  @override
  ResultFuture<List<Product>> call(SearchAllProductParams params) =>
      _repos.searchAllProducts(searchTerm: params.searchTerm, page: params.page);
}

class SearchAllProductParams extends Equatable {
  const SearchAllProductParams({required this.searchTerm, required this.page});

  final String searchTerm;

  final int page;

  @override
  List<Object?> get props => [searchTerm, page];
}
