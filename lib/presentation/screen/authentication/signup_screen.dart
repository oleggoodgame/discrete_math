import 'package:discrete_math/core/auth/signup/bloc/signup_bloc.dart';
import 'package:discrete_math/core/auth/signup/event/signup_event.dart';
import 'package:discrete_math/core/auth/state/auth_state.dart';
import 'package:discrete_math/presentation/widget/text_controller_authentication_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

  void _onSignupPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<SignupBloc>().add(
      SignupPressed(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, AuthState>(
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
                "Sign Up to Discrete Math",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
        
              TextControllerAuthenticationWidget(
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
        
              BlocBuilder<SignupBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
        
                  return SizedBox(
                    width: 200,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => _onSignupPressed(context),
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Sign Up"),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: const Text(
                      " Log in",
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
