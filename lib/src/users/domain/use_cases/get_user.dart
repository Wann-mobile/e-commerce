import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/users/domain/repos/user_repos.dart';

class GetUser extends UseCaseWithParams<User,String> {
  const GetUser(this._userRepos);

  final UserRepos _userRepos;

  @override
  ResultFuture<User> call(String params) => _userRepos.getUser(params);
  
}