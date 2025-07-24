import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/auth/domain/repositories/auth_repo.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepository _repo;
  

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(email: params);
}
