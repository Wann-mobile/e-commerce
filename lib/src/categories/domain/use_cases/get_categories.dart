import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/categories/domain/entities/category.dart' show Category;
import 'package:e_triad/src/categories/domain/repo/category_repo.dart';


class GetCategories extends UseCaseWithOutParams<List<Category>> {
  const GetCategories(this._repos);

  final CategoryRepos _repos;

  @override
  ResultFuture<List<Category>> call() => _repos.getCategories();

  
}