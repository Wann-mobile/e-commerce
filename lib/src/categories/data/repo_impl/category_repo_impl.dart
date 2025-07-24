import 'package:dartz/dartz.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/errors/failures.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/categories/data/data_src/category_remote_data_src.dart';
import 'package:e_triad/src/categories/domain/entities/category.dart';
import 'package:e_triad/src/categories/domain/repo/category_repo.dart';

class CategoryRepoImpl implements CategoryRepos{
const CategoryRepoImpl(this._remoteDataSrc);

  final CategoryRemoteDataSrc _remoteDataSrc;

   @override
  ResultFuture<List<Category>> getCategories() async {
    try {
      final results = await _remoteDataSrc.getCategories();
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Category> getCategory(String categoryId) async {
    try {
      final result = await _remoteDataSrc.getCategory(categoryId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}