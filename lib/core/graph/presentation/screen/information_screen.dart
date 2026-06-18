import 'package:discrete_math/core/graph/domain/entity/eulerian_type.dart';
import 'package:discrete_math/core/graph/domain/entity/graph_entity.dart';
import 'package:discrete_math/core/settings/theme/presentation/style/primary_button_style.dart';
import 'package:discrete_math/core/settings/theme/presentation/style/theme_style.dart';
import 'package:discrete_math/core/graph/presentation/provider/graph_provider.dart';
import 'package:discrete_math/core/graph/presentation/bloc/eulirian_bloc/eulirian_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/graph_bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/presentation/bloc/hamiltonian_bloc/hamiltonian_bloc.dart';
import 'package:discrete_math/shared/widgets/info_card_widget.dart';
import 'package:discrete_math/shared/widgets/primary_button_widget.dart';
import 'package:discrete_math/shared/widgets/text_controller_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InformationScreen extends ConsumerStatefulWidget {
  const InformationScreen({required this.graph, super.key});
  final GraphEntity graph;
  @override
  ConsumerState<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends ConsumerState<InformationScreen> {
  late final TextEditingController _headController;
  @override
  void initState() {
    super.initState();
    final vertices = ref.read(graphProviderProvider);
    final graphMap = {for (final v in vertices) v.data: v};
    context.read<HamiltonianBloc>().add(HamiltonianStart(graphMap));

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<HamiltonianBloc, HamiltonianState>(
              builder: (context, state) {
                if (state is HamiltonianProcessing) {
                  return const InfoCardWidget(
                    title: "Hamiltonian",
                    content: [Text("Processing...")],
                  );
                }

                if (state is HamiltonianResult) {
                  return InfoCardWidget(
                    title: "Hamiltonian",
                    content: [
                      Text(
                        state.analysis.explanation,
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 12),
            BlocBuilder<EulerianBloc, EulirianState>(
              builder: (context, state) {
                if (state is EulirianProcessing) {
                  return const InfoCardWidget(
                    title: "Eulerian",
                    content: [Text("Processing...")],
                  );
                }

                if (state is EulirianResult) {
                  String text;
                  switch (state.type) {
                    case EulerianType.none:
                      text = "There is no Eulerian cycle or path";
                      break;
                    case EulerianType.cycle:
                      text = "There is an Eulerian cycle";
                      break;
                    case EulerianType.path:
                      text = "There is an Eulerian path";
                      break;
                  }

                  return InfoCardWidget(
                    title: "Eulerian",
                    content: [
                      Text(text, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 16),
            InfoCardWidget(
              title: "Head vertex",
              content: [
                TextControllerWidget(
                  controller: _headController,
                  label: "Head",
                  hint: "First vertex",
                  validator: (v) {
                    final connect = _headController.text;
                    final vertices = ref.read(graphProviderProvider);

                    if (connect.isEmpty) {
                      return "Please enter vertex name";
                    }

                    final exists = vertices.any(
                      (vertex) => vertex.data == connect,
                    );

                    if (!exists) {
                      return 'There is no vertex "$connect"';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: sMedium),
                PrimaryButton(text: 'Edit', onPressed: _onEdit),
              ],
            ),

            const SizedBox(height: 20),
            InfoCardWidget(
              title: "Remove your Graph",
              content: [
                PrimaryButton(
                  text: 'Delete',
                  onPressed: _onDelete,
                  style: PrimaryButtonStyle(
                    backgroundColor: Colors.red,
                    borderRadius: 16,
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onEdit() {
    final connect = _headController.text;

    final vertices = ref.read(graphProviderProvider);
    final notifier = ref.read(graphProviderProvider.notifier);

    final newVertex = vertices.firstWhere((v) => v.data == connect);

    notifier.setHead(newVertex);
    context.pop();
  }

  void _onDelete() async {
    context.read<GraphsCubit>().deleteGraph(widget.graph);
    context.go("/graphs");
  }
}
