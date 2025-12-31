import 'package:discrete_math/application/provider/treeVertex_provider.dart';
import 'package:discrete_math/data/entity/treeVertex_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TreeVertexWidget extends ConsumerStatefulWidget {
  final TreeVertex treeVertex;

  const TreeVertexWidget({super.key, required this.treeVertex});

  @override
  ConsumerState<TreeVertexWidget> createState() => _TreeVertexWidgetState();
}

class _TreeVertexWidgetState extends ConsumerState<TreeVertexWidget> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.deferToChild,

          onPanUpdate: (details) {
            ref
                .read(treeVertexProviderProvider.notifier)
                .updateOffset(
                  widget.treeVertex.id,
                  widget.treeVertex.offset + details.delta,
                );
          },
          onLongPress: () {
            setState(() {
              show = !show;
            });
          },
          child: SizedBox(
            width: 50,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: Center(child: Text(widget.treeVertex.data)),
            ),
          ),
        ),
        if (show)
          Positioned(left: -50, child: DeleteVertexButton(vertex:  widget.treeVertex)),

        if (show)
          Positioned(
            right: -50,
            child: EditVertexButton(
              onTap: () => _editVertex(widget.treeVertex),
            ),
          ),
      ],
    );
  }

  void _deleteTreeVertex(TreeVertex vertex) {}

  void _editVertex(TreeVertex vertex) {
    print("WORK");

    context.push('/edit_vertex', extra: vertex);
  }
}

class DeleteVertexButton extends ConsumerWidget {
  final TreeVertex vertex;

  const DeleteVertexButton({super.key, required this.vertex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        print("WORK");
        ref.read(treeVertexProviderProvider.notifier).remove(vertex);
      },
      child: const Icon(Icons.delete),
    );
  }
}

class EditVertexButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditVertexButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: const Icon(Icons.edit),
    );
  }
}
