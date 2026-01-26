import 'package:discrete_math/application/provider/obsucure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextControllerAuthenticationWidget extends ConsumerWidget {
  static const double fieldWidth = 360;

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool password;
  final String? Function(String?)? validator;

  const TextControllerAuthenticationWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.password = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscure = ref.watch(obscureProvider);

    return SizedBox(
      width: fieldWidth,
      child: TextFormField(
        key: super.key,
        controller: controller,
        validator: validator,
        obscureText: password ? obscure : false,
        decoration: password
            ? _inputDecorationPassword(ref)
            : _inputDecoration(),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  InputDecoration _inputDecorationPassword(WidgetRef ref) {
    final obscure = ref.read(obscureProvider);

    return InputDecoration(
      labelText: label,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      suffixIcon: IconButton(
        icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          ref.read(obscureProvider.notifier).state = !obscure;
        },
      ),
    );
  }
}
