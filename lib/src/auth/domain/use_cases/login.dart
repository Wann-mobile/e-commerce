import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:e_triad/core/use_case/use_case.dart';
import 'package:e_triad/core/utils/typedefs.dart';
import 'package:e_triad/src/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class Login extends UseCaseWithParams<User,LoginParams>{
const Login(this._repo);

  
  final AuthRepository _repo;
  
  @override
  ResultFuture<User> call(LoginParams params) => _repo.login(
    email: params.email,
    password: params.password,
  );

 
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });
  const LoginParams.empty() : this(email: 'Test Email', password: 'Test Password');
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}