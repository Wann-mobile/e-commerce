import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/categories/domain/entities/category.dart';
import 'package:e_triad/src/categories/domain/repo/category_repo.dart';


class GetCategory extends UseCaseWithParams<Category, String> {
  const GetCategory(this._repos);
  
  final CategoryRepos _repos;
  
  @override
  ResultFuture<Category> call(String params) =>
      _repos.getCategory(params);
}
