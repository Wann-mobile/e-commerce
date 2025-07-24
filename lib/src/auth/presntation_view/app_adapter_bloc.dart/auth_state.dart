import 'package:equatable/equatable.dart';

import 'package:e_triad/core/common/user_related_entities/user.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

final class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

final class AuthStateOTPsent extends AuthState {
  const AuthStateOTPsent();
}

final class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

final class AuthStateRegistered extends AuthState {
  const AuthStateRegistered();
}

final class AuthStatePasswordReset extends AuthState {
  const AuthStatePasswordReset();
}

final class AuthStateOTPVerified extends AuthState {
  const AuthStateOTPVerified();
}

final class AuthStateTokenVerified extends AuthState {
  const AuthStateTokenVerified(this.isValid);

  final bool isValid;

  @override
  List<Object?> get props => [isValid];
}

final class AuthStateError extends AuthState {
  const AuthStateError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
