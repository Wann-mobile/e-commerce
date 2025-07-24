import 'package:dartz/dartz.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/errors/failures.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/products/data/data_src/product_remote_data_src.dart';
import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:e_triad/src/products/domain/repo/product_repos.dart';


class ProductRepoImpl implements ProductRepos {
  const ProductRepoImpl(this._remoteDataSrc);

  final ProductRemoteDataSrc _remoteDataSrc;
 
  

  @override
  ResultFuture<List<Product>> getAllProducts({int page = 1}) async {
    try {
      final results = await _remoteDataSrc.getAllProducts(page: page);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

 

  @override
  ResultFuture<List<Product>> getNewArrivalProducts({int page = 1}) async {
    try {
      final results = await _remoteDataSrc.getNewArrivalProducts(page: page);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Product>> getPopularProducts({int page = 1}) async {
    try {
      final results = await _remoteDataSrc.getPopularProducts(page: page);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Product> getProduct(String productId) async {
    try {
      final result = await _remoteDataSrc.getProduct(productId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Product>> getProductsByCategory({
    required String category,
    int page = 1,
  }) async {
    try {
      final results = await _remoteDataSrc.getProductsByCategory(
        category: category,
        page: page,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Product>> searchAllProducts({
    required String searchTerm,
    int page = 1,
  }) async {
    try {
      final results = await _remoteDataSrc.searchAllProducts(
        searchTerm: searchTerm,
        page: page,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Product>> searchProductsByCategory({
    required String searchTerm,
    required String category,
    int page = 1,
  }) async {
    try {
      final results = await _remoteDataSrc.searchProductsByCategory(
        searchTerm: searchTerm,
        category: category,
        page: page,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Product>> searchProductsByGenderAgeCategory({
    required String searchTerm,
    required String genderAgeCategory,
    int page = 1,
  }) async {
    try {
      final results = await _remoteDataSrc.searchProductsByGenderAgeCategory(
        searchTerm: searchTerm,
        genderAgeCategory: genderAgeCategory,
        page: page,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
