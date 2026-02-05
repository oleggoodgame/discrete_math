import 'package:discrete_math/core/auth/login/event/login_event.dart';
import 'package:discrete_math/core/auth/login/service/login_service.dart';
import 'package:discrete_math/core/auth/state/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  final LoginService service;

  LoginBloc(this.service) : super(AuthInitial()) {
    on<LoginPressed>(_onLogin);
    on<LogoutPressed>(_onLogout);
  }

  Future<void> _onLogin(LoginPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await service.login(event.email, event.password);

      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError('Bad email or password'));
    } catch (e) {
      emit(AuthError('Bad email or password'));
    }
  }

  void _onLogout(LogoutPressed event, Emitter<AuthState> emit) {
    service.logout();
    emit(AuthInitial());
  }
}
