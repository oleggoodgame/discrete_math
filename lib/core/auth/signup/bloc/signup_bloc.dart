
import 'package:discrete_math/core/auth/signup/event/signup_event.dart';
import 'package:discrete_math/core/auth/signup/service/signup_service.dart';
import 'package:discrete_math/core/auth/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<AuthEvent, AuthState> {
  final SignupService service;

  SignupBloc(this.service) : super(AuthInitial()) {
    on<SignupPressed>(_onRegist);
  }

  Future<void> _onRegist(
    SignupPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      service.signup(
        event.email,
        event.password,
      );
      // emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

}
