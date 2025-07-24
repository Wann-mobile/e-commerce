import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class ResetPassword extends UseCaseWithParams<void, ResetPasswordParams> {
  const ResetPassword(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<void> call(ResetPasswordParams params) =>
      _repo.resetPassword(email: params.email, newPassword: params.newPassword);
}

class ResetPasswordParams extends Equatable {
  const ResetPasswordParams({required this.email, required this.newPassword,});

  final String email;
  final String newPassword;

  @override
  List<Object?> get props => [email, newPassword];
}
