
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LabeledFieldRow extends StatelessWidget {
  final String label;
  final Widget field;

  const LabeledFieldRow({super.key, required this.label, required this.field});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(width: 16),
          field,
        ],
      ),
    );
  }
}
