import 'package:discrete_math/application/provider/graph_provider.dart';
import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:discrete_math/presentation/widget/labaled_field_row_children.dart';
import 'package:discrete_math/presentation/widget/primary_button_widget.dart';
import 'package:discrete_math/presentation/widget/text_controller_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditVertexScreen extends ConsumerStatefulWidget {
  EditVertexScreen({this.vertex, this.editor, super.key});
  bool? editor = false;
  final Vertex? vertex;
  @override
  ConsumerState<EditVertexScreen> createState() => _EditVertexScreenState();
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
        text: vertex.offset.dx.toStringAsFixed(4),
      );

      _offSetYController = TextEditingController(
        text: vertex.offset.dy.toStringAsFixed(4),
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
      appBar: AppBar(title: fifi ? Text('Edit Vertex') : Text('Add Vertex')),
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
                  final vertices = ref.read(graphProviderProvider);
                  final exists = vertices.any(
                    (vertex) => vertex.data == v && vertex != widget.vertex,
                  );
                  print(exists);
                  if (exists) {
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
                  if (v == null || v.isEmpty) {
                    return null;
                  }

                  final value = double.tryParse(v);
                  if (value == null) {
                    return 'Enter a valid number';
                  }
                  if (v.length > 5) {
                    return 'Enter smaller number';
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
                  if (v == null || v.isEmpty) {
                    return null;
                  }

                  final value = double.tryParse(v);
                  if (value == null) {
                    return 'Enter a valid number';
                  }
                  if (v.length > 5) {
                    return 'Enter smaller number';
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
                hint: 'Example: A B C',
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
    final x = double.tryParse(_offSetXController.text) ?? 100;
    final y = double.tryParse(_offSetYController.text) ?? 100;
    final connect = _connectController.text
        .split(RegExp(r'[\s,]+'))
        .where((e) => e.isNotEmpty)
        .toSet();
    final vertex = Vertex(
      data: _nameController.text,
      offset: Offset(x, y),
      connection: connect,
    );
    if (fifi == true) {
      ref
          .read(graphProviderProvider.notifier)
          .editVertex(vertex, widget.vertex!);
    } else {
      ref.read(graphProviderProvider.notifier).addVertex(vertex);
    }
    print("EDIT $vertex");
    print(ref.read(graphProviderProvider).toList());
    context.pop();
  }
}
