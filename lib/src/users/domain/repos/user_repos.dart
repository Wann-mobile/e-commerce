import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/utils/typedefs.dart';

abstract class UserRepos {
  const UserRepos();

  ResultFuture<User> getUser(String userId);
  ResultFuture<User> updateUser({
    required String userId,
    required DataMap updateData,
  });
  
}