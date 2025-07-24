import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/categories/domain/entities/category.dart';

abstract class CategoryRepos {
const CategoryRepos();

// Category operations
  /// Get all categories
  /// Maps to: getCategories()
  ResultFuture<List<Category>> getCategories();

  /// Get a single category by ID
  /// Maps to: getCategoryById(req.params.id)
  ResultFuture<Category> getCategory(String categoryId);

}