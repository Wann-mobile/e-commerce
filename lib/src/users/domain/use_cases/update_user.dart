import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/users/domain/repos/user_repos.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UseCaseWithParams<User, UpdateUserParams> {
  const UpdateUser(this._userRepos);

  final UserRepos _userRepos;

  @override
  ResultFuture<User> call(UpdateUserParams param) =>
      _userRepos.updateUser(userId: param.userId, updateData: param.updateData);
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.userId, required this.updateData});

  final String userId;
  final DataMap updateData;

  @override
  List<Object?> get props => [userId, updateData];
}
