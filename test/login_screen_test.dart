import 'package:discrete_math/core/auth/login/presentation/bloc/login_bloc.dart';
import 'package:discrete_math/core/auth/auth/auth_event.dart';
import 'package:discrete_math/core/auth/login/service/login_service.dart';
import 'package:discrete_math/core/auth/auth/bloc/auth_state.dart';
import 'package:discrete_math/core/auth/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeLoginBloc extends Bloc<AuthEvent, AuthState> implements LoginBloc {
  FakeLoginBloc() : super(AuthInitial()) {
    on<LoginPressed>((event, emit) {
      emit(AuthLoading());
    });
  }

  @override
  // TODO: implement service
  LoginService get service => throw UnimplementedError();
}

void main() async {
  testWidgets('Login form validates email and password', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => FakeLoginBloc(),
            child: const Scaffold(body: LoginScreen()),
          ),
        ),
      ),
    );
    await tester.enterText(find.byKey(const Key('email_field')), 'wrong_email');
    await tester.enterText(find.byKey(const Key('password_field')), '123');

    await tester.tap(find.text('Log In'));
    print("Tested bad");
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('email_field')),
      'test@gmail.com',
    );
    await tester.enterText(find.byKey(const Key('password_field')), '123456');
    print("Tested good");

    await tester.tap(find.text('Log In'));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsNothing);
    expect(find.text('Password must be at least 6 characters'), findsNothing);
  });
}
