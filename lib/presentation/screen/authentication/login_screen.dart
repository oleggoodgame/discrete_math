import 'package:discrete_math/core/auth/login/bloc/login_bloc.dart';
import 'package:discrete_math/core/auth/login/event/login_event.dart';
import 'package:discrete_math/core/auth/state/auth_state.dart';
import 'package:discrete_math/presentation/widget/text_controller_authentication_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<LoginBloc>().add(
      LoginPressed(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Log In to Discrete Math",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
        
              TextControllerAuthenticationWidget(
                key: const Key('email_field'),
        
                controller: _emailController,
                label: "Enter email",
                hint: "example@gmail.com",
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Email is required';
                  }
                  if (!EmailValidator.validate(v)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
        
              TextControllerAuthenticationWidget(
                key: const Key('password_field'),
                password: true,
                controller: _passwordController,
                label: "Enter password",
                hint: "Minimum 6 characters",
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Password is required';
                  }
                  if (v.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
        
              BlocBuilder<LoginBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
        
                  return SizedBox(
                    width: 200,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => _onLoginPressed(context),
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Log In"),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () => context.go('/signup'),
                    child: const Text(
                      " Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
