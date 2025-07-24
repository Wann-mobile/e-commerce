import 'package:dartz/dartz.dart';
import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/errors/exceptions.dart';
import 'package:e_triad/core/errors/failures.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/users/data/user_data_sources/user_remote_data_source.dart';
import 'package:e_triad/src/users/domain/repos/user_repos.dart';

class UserRepoImpl implements UserRepos {
  const UserRepoImpl(this._remoteDataSrc);

  final UserRemoteDataSource _remoteDataSrc;

  @override
  ResultFuture<User> getUser(String userId) async {
    try {
      final results = await _remoteDataSrc.getUser(userId);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

 

  @override
  ResultFuture<User> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final results = await _remoteDataSrc.updateUser(
        userId: userId,
        updateData: updateData,
      );
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
