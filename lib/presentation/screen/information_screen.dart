import 'package:discrete_math/application/provider/graph_provider.dart';
import 'package:discrete_math/core/eulerian/bloc/eulirian_bloc.dart';
import 'package:discrete_math/core/eulerian/event/eulirian_event.dart';
import 'package:discrete_math/core/eulerian/state/eulirian_state.dart';
import 'package:discrete_math/core/eulerian/type/eulirian_type.dart';
import 'package:discrete_math/core/hamiltonian/bloc/hamiltonian_bloc.dart';
import 'package:discrete_math/core/hamiltonian/event/hamiltonian_event.dart';
import 'package:discrete_math/core/hamiltonian/state/hamiltonian_state.dart';
import 'package:discrete_math/presentation/widget/labaled_field_row_children.dart';
import 'package:discrete_math/presentation/widget/primary_button_widget.dart';
import 'package:discrete_math/presentation/widget/text_controller_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InformationScreen extends ConsumerStatefulWidget {
  const InformationScreen({super.key});

  @override
  ConsumerState<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends ConsumerState<InformationScreen> {
  late final TextEditingController _headController;
  @override
  void initState() {
    super.initState();
    final vertices = ref.read(graphProviderProvider);

    context.read<HamiltonianBloc>().add(HamiltonianStart(vertices));

    context.read<EulerianBloc>().add(EulerianStart(vertices));
    _headController = TextEditingController(
      text: vertices.isNotEmpty ? vertices.first.data : '',
    );
  }

  @override
  void dispose() {
    _headController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<HamiltonianBloc, HamiltonianState>(
            builder: (context, state) {
              if (state is HamiltonianInitial) {
                return const SizedBox.shrink();
              }

              if (state is HamiltonianProcessing) {
                return const LabeledFieldRow(
                  label: "Hamiltonian:",
                  field: Text("Processing..."),
                );
              }

              if (state is HamiltonianResult) {
                return LabeledFieldRow(
                  label: "Hamiltonian:",
                  field: Text(state.analysis.explanation),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<EulerianBloc, EulirianState>(
            builder: (context, state) {
              if (state is EulirianInitial) {
                return const SizedBox.shrink();
              }

              if (state is EulirianProcessing) {
                return const LabeledFieldRow(
                  label: "Hamiltonian:",
                  field: Text("Processing..."),
                );
              }

              if (state is EulirianResult) {
                if (state.type == EulerianType.none) {
                  return LabeledFieldRow(
                    label: "Eulirian:",
                    field: Text("There is no Eulirian cycle or path"),
                  );
                }
                if (state.type == EulerianType.cycle) {
                  return LabeledFieldRow(
                    label: "Eulirian:",
                    field: Text("There is no Eulirian cycle"),
                  );
                }
                if (state.type == EulerianType.path) {
                  return LabeledFieldRow(
                    label: "Eulirian:",
                    field: Text("There is no Eulirian path"),
                  );
                }
              }

              return const SizedBox.shrink();
            },
          ),
          LabeledFieldRow(
            label: "Head vertex: ",
            field: TextControllerWidget(
              controller: _headController,
              label: "Head",
              hint: "First vertext",
              validator: (v) {
                final connect = _headController.text;
                final vertices = ref.read(graphProviderProvider);

                final exists = vertices.any((vertex) => vertex.data == connect);

                if (!exists) {
                  if (connect.isEmpty) {
                    return "Please enter name vertex";
                  }
                  return 'There is no vertex with name "$connect"';
                }

                return null;
              },
            ),
          ),
          PrimaryButton(
            text: 'Edit',
            onPressed: () {
              _onSubmit();
            },
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    final connect = _headController.text;

    final vertices = ref.read(graphProviderProvider);
    final notifier = ref.read(graphProviderProvider.notifier);

    final newVertex = vertices.firstWhere((v) => v.data == connect);

    notifier.setHead(newVertex);
    context.pop();
  }
}
