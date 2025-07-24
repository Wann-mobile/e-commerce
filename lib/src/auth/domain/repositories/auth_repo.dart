import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/utils/typedefs.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  });
  ResultFuture<User> login({required String email, required String password});
  ResultFuture<void> forgotPassword({required String email});
  ResultFuture<void> verifyOtp({required String email, required String otp});
  ResultFuture<void> resetPassword({
    required String email,
    required String newPassword,
  });
  ResultFuture<bool> verifyToken();
}
