import 'package:discrete_math/application/data/style/theme_style.dart';
import 'package:discrete_math/core/auth/auth/presentation/bloc/auth_bloc.dart';
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

    context.read<AuthBloc>().add(
      SignupPressed(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: sLarge),
                      Text(
                        'Sign Up to Discrete Math',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                  Column(
                    children: [
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
                      const SizedBox(height: sMedium),
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
                          if(v.length>77){
                            return "The password is too long, please change it";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: sLarge),

                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;

                          return SizedBox(
                            height: 52,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => _onSignupPressed(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('SIGN UP'),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: sSmall),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;
                          return SizedBox(
                            height: 52,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => _onGooglePressed(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.indigoAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.black,
                                      ),
                                    )
                                  : const Text('SIGN IN WITH GOOGLE'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: sMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        InkWell(
                          onTap: () => context.go('/login'),
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onGooglePressed(BuildContext context) async {
    context.read<AuthBloc>().add(GoogleStart());
  }
}
