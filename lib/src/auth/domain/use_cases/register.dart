import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class Register extends UseCaseWithParams<void, RegisterParams> {
  const Register(this._repo);
  final AuthRepository _repo;

  @override
  ResultFuture<void> call(RegisterParams params) => _repo.register(
    name: params.name,
    email: params.email,
    password: params.password,
    phone: params.phone,
  );
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  final String name;
  final String email;
  final String password;
  final String phone;

  @override
  List<Object?> get props => [name, email, password, phone];
}
