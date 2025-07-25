import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

 part 'current_user_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() => null;

  void setUser(User? user) {
    if (state != user) state = user;
  }
}
