import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class VerifyOtp extends UseCaseWithParams<void, VerifyOtpParams> {
  const VerifyOtp(this._repo);
  final AuthRepository _repo;
  @override
  ResultFuture<void> call(VerifyOtpParams params) =>
      _repo.verifyOtp(email: params.email, otp: params.otp);
}

class VerifyOtpParams extends Equatable {
  const VerifyOtpParams({required this.otp, required this.email});

  final String otp;
  final String email;

  @override
  List<Object?> get props => [otp, email];
}
