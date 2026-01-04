// import 'dart:collection';
// import 'dart:isolate';

// import 'package:discrete_math/application/provider/graph_provider.dart';
// import 'package:discrete_math/data/entity/vertex_entity.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Path {
//   final Set<String> pipa = {};
//   final WidgetRef ref;
//   Path({required this.ref});
//   // Future<Set<String>> algorith_path_1(
//   //   Vertex vertex,
//   //   String find,
//   //   WidgetRef ref,
//   // ) async {
//   //   pipa.add(vertex.data);
//   //   final differnce = vertex.connection.difference(pipa);

//   //   if (vertex.connection.contains(find)) {
//   //     return pipa;
//   //   } else {
//   //     for (final i in differnce) {
//   //       final new_vertex = ref
//   //           .read(graphProviderProvider.notifier)
//   //           .state
//   //           .where((V) => V.data == i)
//   //           .single;
//   //       await Isolate.run(() {
//   //         return algorith_path_1(new_vertex, find, ref);
//   //       });
//   //     }
//   //   }
//   // }

//   // Set<String> algorith_path_2(Vertex vertex, String find) {
//   //   final new_vertex = vertex;
//   //   final sets = {};
//   //   while (!new_vertex.connection.contains(find)) {}
//   // }
//   Set<Vertex> bfs(Vertex start) {
//     final queue = Queue<Vertex>();
//     final Set<Vertex> visited = {};

//     int index = 0;

//     queue.add(start);
//     visited.add(start);

//     while (queue.isNotEmpty) {
//       final current = queue.removeFirst();
//       index++;

//       print(
//         "Вершина: ${current.data}\tBFS-номер: $index\tЧерга: ${queue.map((v) => v.data)}",
//       );

//       for (final neighbor in current.connection) {
//         if (!visited.contains(neighbor)) {
//           final Vertex vertex = ref
//               .read(graphProviderProvider.notifier)
//               .find(neighbor);
//           visited.add(vertex);
//           queue.add(vertex);
//         }
//       }
//     }

//     return visited;
//   }
// }
