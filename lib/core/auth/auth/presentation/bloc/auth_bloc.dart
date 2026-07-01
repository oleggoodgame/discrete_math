import 'dart:async';
import 'package:discrete_math/core/auth/login/domain/repository/ilogin_repository.dart';
import 'package:discrete_math/core/auth/signup/domain/repostiory/signup_repostiory.dart';
import 'package:discrete_math/core/graph/domain/usecases/loadGraphs_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepostiory loginRepository;
  final SignupRepostiory signupRepository;
  final LoadgraphsUsecase loadgraphsUsecase;
  AuthBloc(this.loginRepository, this.signupRepository, this.loadgraphsUsecase) : super(AuthInitial()) {
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
      await loadgraphsUsecase();
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
