import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/domain/repo/product_repos.dart';
import 'package:equatable/equatable.dart';

class SearchProductsByGenderAgeCategory extends UseCaseWithParams<List<Product>, SearchProductsByGenderAgeCategoryParams> {
  const SearchProductsByGenderAgeCategory(this._repos);
  
  final ProductRepos _repos;
  
  @override
  ResultFuture<List<Product>> call(SearchProductsByGenderAgeCategoryParams params) =>
      _repos.searchProductsByGenderAgeCategory(
        searchTerm: params.searchTerm,
        genderAgeCategory: params.genderAgeCategory,
        page: params.page
      );
}

class SearchProductsByGenderAgeCategoryParams extends Equatable {
  const SearchProductsByGenderAgeCategoryParams({
    required this.searchTerm,
    required this.genderAgeCategory,
    required this.page 
  });
  
  final String searchTerm;
  final String genderAgeCategory;
  final int page;
  
  @override
  List<Object> get props => [searchTerm, genderAgeCategory, page];
}