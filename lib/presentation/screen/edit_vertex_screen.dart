import 'package:discrete_math/application/provider/graph_provider.dart';
import 'package:discrete_math/data/entity/vertex_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditVertexScreen extends ConsumerStatefulWidget {
  EditVertexScreen({this.vertex, this.editor, super.key});
  bool? editor = false;
  Vertex? vertex;
  @override
  ConsumerState<EditVertexScreen> createState() =>
      _EditVertexScreenState();
}

class _EditVertexScreenState extends ConsumerState<EditVertexScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _offSetXController;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _offSetYController;

  late final TextEditingController _connectController;
  @override
  void initState() {
    super.initState();
    if ((widget.editor ?? false) && widget.vertex != null) {
      final vertex = widget.vertex!;
      _nameController = TextEditingController(text: vertex.data);
      _offSetXController = TextEditingController(
        text: vertex.offset.dx.toString(),
      );
      _offSetYController = TextEditingController(
        text: vertex.offset.dy.toString(),
      );
      _connectController = TextEditingController(
        text: vertex.connection.join(' '),
      );
    } else {
      _nameController = TextEditingController();
      _offSetXController = TextEditingController();
      _offSetYController = TextEditingController();
      _connectController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _clearControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fifi = widget.editor ?? false;
    return Scaffold(
      appBar: AppBar(
        title: fifi ? Text('Edit Tree Vertex') : Text('Add Tree Vertex'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LabeledFieldRow(
              label: 'Name',
              field: TextControllerWidget(
                controller: _nameController,
                label: 'data',
                hint: 'Enter name, less than 4 characters',
                validator: (v) {
                  if (ref.read(graphProviderProvider).contains(v)) {
                    return 'There already this name';
                  }
                  if (v != null && v.length >= 4) {
                    return 'Name must be less than 4 characters';
                  }
                  return null;
                },
              ),
            ),
            LabeledFieldRow(
              label: 'X position',
              field: TextControllerWidget(
                controller: _offSetXController,
                label: 'Offset X position',
                hint: 'Enter offset X',
                validator: (v) {
                  if (v != null && v.length < 1 && v.length > 4) {
                    return 'must be less than 1000 and more than 0';
                  }
                  return null;
                },
              ),
            ),

            LabeledFieldRow(
              label: 'Y position',
              field: TextControllerWidget(
                controller: _offSetYController,
                label: 'Offset Y position',
                hint: 'Enter offset Y',
                validator: (v) {
                  if (v != null && v.length < 1 && v.length > 4) {
                    return 'must be less than 1000 and more than 0';
                  }
                  return null;
                },
              ),
            ),
            LabeledFieldRow(
              label: 'Connect to',
              field: TextControllerWidget(
                controller: _connectController,
                label: 'Enter names, that you want to connect to',
                hint: 'Example: 1 A 3 4',
                validator: (v) {
                  final connect = _connectController.text
                      .split(' ')
                      .where((e) => e.trim().isNotEmpty)
                      .toSet();
                  final vertices = ref.read(graphProviderProvider);

                  for (final i in connect) {
                    final exists = vertices.any((vertex) => vertex.data == i);

                    if (!exists) {
                      if (connect.isEmpty) {
                        return null;
                      }
                      return 'There is no vertex with name "$i"';
                    }
                  }

                  return null;
                },
              ),
            ),
            PrimaryButton(
              text: fifi ? 'Edit Vertex' : 'Add Vertex',
              onPressed: () {
                _onSubmit(fifi);
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _clearControllers() {
    _nameController.clear();
    _offSetXController.clear();
    _offSetYController.clear();
    _connectController.clear();
  }

  void _onSubmit(bool fifi) {
    if (!_formKey.currentState!.validate()) return;

    final connect = _connectController.text.split(' ').toSet();

    final vertex = Vertex(
      data: _nameController.text,
      offset: Offset(
        double.parse(_offSetXController.text),
        double.parse(_offSetYController.text),
      ),
      connection: connect,
    );
    if (fifi == true) {
      ref
          .read(graphProviderProvider.notifier)
          .editVertex(vertex);
    } else {
      ref.read(graphProviderProvider.notifier).addVertex(vertex);
    }
    // final vertex = Vertex(
    //   data: _nameController.text,
    //   data: _nameController.text,
    //   offset: Offset(
    //     double.parse(_offSetXController.text),
    //     double.parse(_offSetYController.text),
    //   ),
    //   connection: connect,
    // );
    context.go('/editor');
  }
}

class TextControllerWidget extends StatelessWidget {
  static const double fieldWidth = 260;

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;

  const TextControllerWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fieldWidth,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: _inputDecoration(),
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
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

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
