import 'dart:async';
import 'package:discrete_math/core/auth/login/data/repository/ilogin_repository.dart';
import 'package:discrete_math/core/auth/signup/data/repository/signup_repostiory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepostiory loginRepository;
  final SignupRepostiory signupRepository;
  AuthBloc(this.loginRepository, this.signupRepository) : super(AuthInitial()) {
    on<LoginPressed>(_onLogin);
    on<SignupPressed>(_onSignup);
    on<LogoutPressed>(_onLogout);
    on<GoogleStart>(_onGoogleStart);
  }
  Future<void> _onLogin(LoginPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await loginRepository.login(event.email, event.password);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError('Bad email or password'));
    }
  }

  Future<void> _onSignup(SignupPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signupRepository.signup(event.email, event.password);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError('Signup failed'));
    }
  }

  void _onLogout(LogoutPressed event, Emitter<AuthState> emit) {
    loginRepository.logout();
    emit(AuthInitial());
  }

  FutureOr<void> _onGoogleStart(GoogleStart event, Emitter<AuthState> emit) {}
}
