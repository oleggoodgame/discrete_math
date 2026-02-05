
import 'package:discrete_math/core/auth/signup/event/signup_event.dart';
import 'package:discrete_math/core/auth/signup/service/signup_service.dart';
import 'package:discrete_math/core/auth/state/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      final user = await service.signup(
        event.email,
        event.password,
      );

      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError("Registration failed, try another email"));
    } catch (e) {
      emit(AuthError('Registration failed, try another email'));
    }
  }

}
