import 'package:discrete_math/core/graph/presentation/provider/connect_vertex_provider.dart';
import 'package:discrete_math/core/graph/presentation/provider/selected_vertexes_provider.dart';
import 'package:discrete_math/core/graph/presentation/provider/graph_provider.dart';
import 'package:discrete_math/core/graph/domain/entity/vertex_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TreeVertexWidget extends ConsumerWidget {
  final Vertex vertex;

  const TreeVertexWidget({super.key, required this.vertex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final fifi = ref.watch(fifiConectProvider);
    final selected = ref.watch(selectedVertexProvider);
    final connectState = ref.watch(connectVertexProvider);
    final connectNotifier = ref.read(connectVertexProvider.notifier);
    final graphNotifier = ref.read(graphProviderProvider.notifier);
    final fifi = Theme.of(context).brightness == Brightness.light;

    final isMenuOpen = selected?.data == vertex.data;
    final isConnecting = connectState != null;
    return IgnorePointer(
      ignoring: isMenuOpen,
      child: GestureDetector(
        onTap: () {
          if (!isConnecting) {
            ref.read(selectedVertexProvider.notifier).state = vertex;
            return;
          }

          connectNotifier.connect(vertex, graphNotifier);
        },
        onPanUpdate: (details) {
          if (!isConnecting) {
            graphNotifier.updateOffset(
              vertex.data,
              vertex.offset + details.delta,
            );
          }
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: fifi ? Colors.white : Colors.grey.shade400,
            border: Border.all(color: Colors.black, width: 4),
          ),
          alignment: Alignment.center,
          child: Text(vertex.data, style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}

class VertexContextMenu extends ConsumerWidget {
  final Vertex vertex;

  const VertexContextMenu({super.key, required this.vertex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              ref.read(selectedVertexProvider.notifier).state = null;
              ref.read(selectedVertexProvider.notifier).state = null;
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/edit_vertex', extra: vertex);
              ref.read(selectedVertexProvider.notifier).state = null;
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(graphProviderProvider.notifier).remove(vertex);
              ref.read(selectedVertexProvider.notifier).state = null;
            },
          ),
          IconButton(
            icon: const Icon(Icons.north_rounded),
            onPressed: () {
              ref.read(connectVertexProvider.notifier).start(vertex);
              ref.read(selectedVertexProvider.notifier).state = null;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Tap another vertex to connect")),
              );
            },
          ),
        ],
      ),
    );
  }
}

class VertexContextMenuS extends ConsumerWidget {
  final Vertex vertex;

  const VertexContextMenuS({super.key, required this.vertex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Close (top)
            Positioned(
              top: -35,
              left: -50,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  ref.read(selectedVertexProvider.notifier).state = null;
                },
              ),
            ),

            Positioned(
              top: -5,
              left: -85,
              child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.push('/edit_vertex', extra: vertex);
                  ref.read(selectedVertexProvider.notifier).state = null;
                },
              ),
            ),

            Positioned(
              top: -5,
              left: -15,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(graphProviderProvider.notifier).remove(vertex);
                  ref.read(selectedVertexProvider.notifier).state = null;
                },
              ),
            ),
            Positioned(
              top: 35,
              left: -50,
              child: IconButton(
                icon: const Icon(Icons.north_rounded),
                onPressed: () {
                  ref.read(connectVertexProvider.notifier).start(vertex);
                  ref.read(selectedVertexProvider.notifier).state = null;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Tap another vertex to connect"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
