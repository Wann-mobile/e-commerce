import 'package:bloc/bloc.dart';
import 'package:e_triad/core/common/app/bloc_providers/user_provider.dart';
import 'package:e_triad/src/auth/domain/use_cases/forgot_password.dart';
import 'package:e_triad/src/auth/domain/use_cases/login.dart';
import 'package:e_triad/src/auth/domain/use_cases/register.dart';
import 'package:e_triad/src/auth/domain/use_cases/reset_password.dart';
import 'package:e_triad/src/auth/domain/use_cases/verify_otp.dart';
import 'package:e_triad/src/auth/domain/use_cases/verify_token.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_event.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required ForgotPassword forgotPassword,
    required Login login,
    required Register register,
    required ResetPassword resetPassword,
    required VerifyOtp verifyOtp,
    required VerifyToken verifyToken,
    required UserProvider userProvider,
  }) : _forgotPassword = forgotPassword,
       _login = login,
       _register = register,
       _resetPassword = resetPassword,
       _verifyOtp = verifyOtp,
       _verifyToken = verifyToken,
       _userProvider = userProvider,
       super(const AuthStateInitial()) {
    on<EventLoginRequested>(_onLoginRequested);
    on<EventRegisterRequested>(_onRegisterRequested);
    on<EventForgotPasswordRequested>(_onForgotPasswordRequested);
    on<EventResetPasswordRequested>(_onResetPasswordRequested);
    on<EventVerifyOtpRequested>(_onVerifyOtpRequested);
    on<EventVerifyTokenRequested>(_onVerifyTokenRequested);
  }

  final ForgotPassword _forgotPassword;
  final Login _login;
  final Register _register;
  final ResetPassword _resetPassword;
  final VerifyOtp _verifyOtp;
  final VerifyToken _verifyToken;
  final UserProvider _userProvider;

  Future<void> _onLoginRequested(
    EventLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    final result = await _login(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold((failure) => emit(AuthStateError(failure.message)), (user) {
      _userProvider.setUser(user);
      emit(AuthStateLoggedIn(user));
    });
  }

  Future<void> _onRegisterRequested(
    EventRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    final result = await _register(
      RegisterParams(
        email: event.email,
        password: event.password,
        name: event.name,
        phone: event.phone,
      ),
    );
    result.fold(
      (failure) => emit(AuthStateError(failure.message)),
      (_) => emit(const AuthStateRegistered()),
    );
  }

  Future<void> _onForgotPasswordRequested(
    EventForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    final result = await _forgotPassword(event.email);
    result.fold(
      (failure) => emit(AuthStateError(failure.message)),
      (_) => emit(const AuthStateOTPsent()),
    );
  }

  Future<void> _onResetPasswordRequested(
    EventResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    final result = await _resetPassword(
      ResetPasswordParams(
       
        newPassword: event.newPassword,
        email: event.email,
      ),
    );
    result.fold(
      (failure) => emit(AuthStateError(failure.message)),
      (_) => emit(const AuthStatePasswordReset()),
    );
  }

  Future<void> _onVerifyOtpRequested(
    EventVerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    final result = await _verifyOtp(
      VerifyOtpParams(otp: event.otp, email: event.email),
    );
    result.fold(
      (failure) => emit(AuthStateError(failure.message)),
      (_) => emit(const AuthStateOTPVerified()),
    );
  }

  Future<void> _onVerifyTokenRequested(
    EventVerifyTokenRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateLoading());
    final result = await _verifyToken();
    result.fold((failure) => emit(AuthStateError(failure.message)), (isValid) {
      emit(AuthStateTokenVerified(isValid));
      if (!isValid) _userProvider.setUsernull();
    });
  }
}
