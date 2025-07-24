import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class EventLoginRequested extends AuthEvent {
  const EventLoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

final class EventRegisterRequested extends AuthEvent {
  const EventRegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  final String email;
  final String password;
  final String name;
  final String phone;

  @override
  List<Object> get props => [email, password, name, phone];
}

final class EventForgotPasswordRequested extends AuthEvent {
  const EventForgotPasswordRequested({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

final class EventResetPasswordRequested extends AuthEvent {
  const EventResetPasswordRequested({
    
    required this.newPassword,
    required this.email,
  });

  
  final String newPassword;
  final String email;

  @override
  List<Object> get props => [ newPassword, email];
}

final class EventVerifyOtpRequested extends AuthEvent {
  const EventVerifyOtpRequested({required this.otp, required this.email});

  final String otp;
  final String email;

  @override
  List<Object> get props => [otp, email];
}

final class EventVerifyTokenRequested extends AuthEvent {
  const EventVerifyTokenRequested();
}
