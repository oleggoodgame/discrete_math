import 'dart:collection';

import 'package:discrete_math/application/data/entity/vertex_entity.dart';

class DetourService {
  // Stream<Set<Vertex>> detourSteps({
  //   required Vertex start,
  //   required Vertex find,
  //   required Map<String, Vertex> graph,
  // }) async* {
  //   final queue = Queue<Vertex>();
  //   final visited = <Vertex>{};
  //   final path = <Vertex>{start};
  //   final deleted = <Vertex>{};

  //   queue.add(start);
  //   while (queue.isNotEmpty) {
  //     final current = queue.removeFirst();

  //     print("Queue: $queue");
  //     print("Current: $current");
  //     final visiting = current.copyWith(state: VertexState.visiting);
  //     visited.add(visiting);

  //     yield {...visited};
  //     await Future.delayed(const Duration(milliseconds: 300));
  //     print("Visited: $visited");
  //     for (final id in current.connection) {
  //       final neighbor = graph[id];
  //       final fifi = visited.where((v) => v.data == id).toSet();
  //       // print("FIFI: $fifi");
  //       if (neighbor != null && fifi.isEmpty) {
  //         path.add(neighbor);
  //         queue.add(neighbor);
  //       } else {
  //         for (final i in neighbor!.connection) {
  //           final delete = graph[i];
  //           if (delete == start) {
  //             continue;
  //           }
  //           path.remove(delete);
  //         }
  //       }
  //     }
  //     print("PATH: $path");
  //     if (!path.contains(find)) {
  //       // for(final id in path){
  //       //   final
  //       // }
  //     } else {
  //       yield path;
  //       break;
  //     }
  //     final done = visiting.copyWith(state: VertexState.visited);
  //     visited
  //       ..remove(visiting)
  //       ..add(done);
  //     // print("END: $visited");
  //     yield {...visited};
  //     await Future.delayed(const Duration(milliseconds: 300));
  //   }
  // }
  // Stream<Set<Vertex>> detourSteps({
  //   required Vertex start,
  //   required Vertex find,
  //   required Map<String, Vertex> graph,
  // }) async* {
  //   final queue_start = Queue<Vertex>();
  //   final queue_find = Queue<Vertex>();

  //   final visited_start = <Vertex>{};
  //   final visited_find = <Vertex>{};

  //   final path = <Vertex>{start};
  //   final deleted = <Vertex>{};

  //   queue_start.add(start);
  //   queue_find.add(find);
  //   // Vertex current_start = queue_start.first;
  //   while (queue_start.isNotEmpty) {
  //     final current_start = queue_start.first;
  //     print("Queue_start: $queue_start");
  //     print("Queue_find: $queue_find");

  //     final visiting = current_start.copyWith(state: VertexState.visiting);
  //     visited.add(visiting);

  //     yield {...visited};
  //     await Future.delayed(const Duration(milliseconds: 300));
  //     print("Visited: $visited");
  //     for (final id in current_start.connection) {
  //       final neighbor = graph[id];
  //       final fifi = visited.where((v) => v.data == id).toSet();
  //       // print("FIFI: $fifi");
  //       if (neighbor != null && fifi.isEmpty) {
  //         path.add(neighbor);
  //         queue.add(neighbor);
  //       } else {
  //         for (final i in neighbor!.connection) {
  //           final delete = graph[i];
  //           if (delete == start) {
  //             continue;
  //           }
  //           path.remove(delete);
  //         }
  //       }
  //     }
  //     final common = findCommon(queue_start, queue_find);

  //     if (common != null) {
  //       print("FOUND COMMON: ${common.data}");
  //       // тут ти ЗГОРТАЄШ алгоритм
  //       break;
  //     }

  //     final done = visiting.copyWith(state: VertexState.visited);
  //     visited
  //       ..remove(visiting)
  //       ..add(done);
  //     // print("END: $visited");
  //     yield {...visited};
  //     await Future.delayed(const Duration(milliseconds: 300));
  //   }
  // }

  // Stream<Set<Vertex>> detourSteps2({
  //   required Vertex start,
  //   required Vertex find,
  //   required Map<String, Vertex> graph,
  // }) async* {
  //   final queue_start = Queue<Vertex>();
  //   final queue_find = Queue<Vertex>();

  //   queue_start.add(start);
  //   queue_find.add(find);
  //   final path = <Vertex>{start, find};

  //   while (queue_start.isNotEmpty && queue_find.isNotEmpty) {
  //     final s = queue_start.removeFirst();
  //     final f = queue_find.removeFirst();

  //     // розширяєш start
  //     for (final id in s.connection) {
  //       final n = graph[id];
  //       if (n != null) queue_start.add(n);
  //     }

  //     // розширяєш find
  //     for (final id in f.connection) {
  //       final n = graph[id];
  //       if (n != null) queue_find.add(n);
  //     }

  //     final common = findCommon(queue_start.toSet(), queue_find.toSet());
  //     if (common != null) {
  //       print("MEET AT ${common.data}");
  //       detourSteps2(graph: graph, start: start, find: common);
  //       break;
  //     }
  //   }
  // }

  Stream<Set<Vertex>> detourSteps4({
    // one of the best
    required Vertex start,
    required Vertex find,
    required Map<String, Vertex> graph,
  }) async* {
    final queueStart = Queue<Vertex>();
    final queueFind = Queue<Vertex>();
    final Set<Vertex> visitedStart = <Vertex>{};
    final Set<Vertex> visitedFind = <Vertex>{};
    final path = <Vertex>{start, find};
    final visitedCommon = <Vertex>{};
    queueStart.add(start.copyWith(state: VertexState.visiting));
    queueFind.add(find.copyWith(state: VertexState.visiting));

    int step = 0;

    while (queueStart.isNotEmpty || queueFind.isNotEmpty) {
      step++;
      print("=== STEP $step ===");
      print("Queue Start: ${queueStart.map((v) => v.data).toList()}");
      print("Queue Find: ${queueFind.map((v) => v.data).toList()}");
      print("Visited Start: ${visitedStart.map((v) => v.data).toList()}");
      print("Visited Find: ${visitedFind.map((v) => v.data).toList()}");
      print("Current Path: ${path.map((v) => v.data).toList()}");

      if (queueStart.isNotEmpty) {
        final s = queueStart.removeFirst();
        print("Processing Start: ${s.data}");
        visitedStart.add(s.copyWith(state: VertexState.visiting));
        visitedCommon.add(s.copyWith(state: VertexState.visiting));
        yield {...visitedCommon};
        for (final id in s.connection) {
          final n = graph[id];
          // print("N: $n");
          // print("${visitedStart.where((v)=>v.data==n.data).toSet().isEmpty}");
          if (n != null &&
              visitedStart.where((v) => v.data == n.data).toSet().isEmpty) {
            visitedStart.add(n);
            queueStart.add(n);
          }
        }
      }

      if (queueFind.isNotEmpty) {
        final f = queueFind.removeFirst();
        print("Processing Find: ${f.data}");
        // visitedFind.add(f.copyWith(state: VertexState.visiting));
        visitedCommon.add(f.copyWith(state: VertexState.visiting));
        yield {...visitedCommon};
        for (final id in f.connection) {
          final n = graph[id];
          if (n != null && !visitedFind.contains(n)) {
            visitedFind.add(n);
            queueFind.add(n);
            print("Added to Queue Find: ${n.data}");
          }
        }
      }
      final commons = findCommons(visitedStart, visitedFind, path);
      if (commons != null) {
        for (final v in commons) {
          print("MEET AT ${v.data}");
          path.add(v.copyWith(state: VertexState.visited));
          print(path);
        }
        if (commons.contains(start) && commons.contains(find)) {
          break;
        }
      }
      if (visitedStart.any((v) => v.data == find.data)) {
        print("START side reached FIND");
        final updatedPath = <Vertex>{};
        for (final v in path) {
          updatedPath.add(v.copyWith(state: VertexState.visited));
        }
        path
          ..clear()
          ..addAll(updatedPath);
        yield {...path};

        break;
      }

      if (visitedFind.any((v) => v.data == start.data)) {
        final updatedPath = <Vertex>{};
        for (final v in path) {
          updatedPath.add(v.copyWith(state: VertexState.visited));
        }
        path
          ..clear()
          ..addAll(updatedPath);
        yield {...path};

        break;
      }

      // yield {...path};
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  Vertex? findCommon(Set<Vertex> q1, Set<Vertex> q2) {
    final set1 = q1.map((v) => v.data).toSet();

    for (final v in q2) {
      if (set1.contains(v.data)) {
        return v; // знайшли спільну вершину
      }
    }
    return null;
  }

  Set<Vertex>? findCommons(
    Set<Vertex> visitedStart,
    Set<Vertex> visitedFind,
    Set<Vertex> path,
  ) {
    final commons = <Vertex>{};

    for (final v in visitedStart) {
      if (visitedFind.contains(v) && !path.contains(v)) {
        commons.add(v);
      }
    }

    return commons.isEmpty ? null : commons;
  }

  Set<Vertex>? findCommonsString(
    Set<String> visitedStart,
    Set<String> visitedFind,
    Set<Vertex> path,
    Map<String, Vertex> graph,
  ) {
    final commons = <Vertex>{};

    for (final id in visitedStart) {
      if (visitedFind.contains(id) && !path.any((v) => v.data == id)) {
        commons.add(graph[id]!.copyWith(state: VertexState.visited));
      }
    }

    return commons.isEmpty ? null : commons;
  }

  // Stream<Set<Vertex>> detourSteps5({
  //   // the best that i done
  //   required Vertex start,
  //   required Vertex find,
  //   required Map<String, Vertex> graph,
  // }) async* {
  //   final queueStart = Queue<Vertex>();
  //   final queueFind = Queue<Vertex>();
  //   final Set<String> visitedStart = <String>{};
  //   final Set<String> visitedFind = <String>{};
  //   final path = <Vertex>{start, find};
  //   final visitedCommon = <Vertex>{};
  //   queueStart.add(start.copyWith(state: VertexState.visiting));
  //   queueFind.add(find.copyWith(state: VertexState.visiting));
  //   visitedStart.add(start.data);
  //   visitedFind.add(find.data);
  //   final parentStart = <String, String?>{};
  //   final parentFind = <String, String?>{};
  //   int step = 0;

  //   while (queueStart.isNotEmpty || queueFind.isNotEmpty) {
  //     step++;
  //     print("=== STEP $step ===");
  //     print("Queue Start: ${queueStart.map((v) => v.data).toList()}");
  //     print("Queue Find: ${queueFind.map((v) => v.data).toList()}");
  //     print("Visited Start: ${visitedStart.map((v) => v).toList()}");
  //     print("Visited Find: ${visitedFind.map((v) => v).toList()}");
  //     print("Current Path: ${path.map((v) => v.data).toList()}");

  //     if (queueStart.isNotEmpty) {
  //       final s = queueStart.removeFirst();
  //       print("Processing Start: ${s.data}");
  //       visitedCommon.add(s.copyWith(state: VertexState.visiting));
  //       yield {...visitedCommon};
  //       for (final id in s.connection) {
  //         final n = graph[id];
  //         // print("N: $n");
  //         // print("${visitedStart.where((v)=>v.data==n.data).toSet().isEmpty}");
  //         if (n != null && !visitedStart.contains(n.data)) {
  //           visitedStart.add(n.data);
  //           parentStart[start.data] = null;
  //           queueStart.add(n);
  //         }
  //       }
  //     }

  //     if (queueFind.isNotEmpty) {
  //       final f = queueFind.removeFirst();
  //       print("Processing Find: ${f.data}");
  //       visitedCommon.add(f.copyWith(state: VertexState.visiting));
  //       yield {...visitedCommon};
  //       for (final id in f.connection) {
  //         final n = graph[id];
  //         if (n != null && !visitedFind.contains(n.data)) {
  //           visitedFind.add(n.data);
  //           queueFind.add(n);
  //           print("Added to Queue Find: ${n.data}");
  //         }
  //       }
  //     }
  //     final common = findCommonString(visitedStart, visitedFind, path, graph);
  //     if (common != null) {
  //       final meetId = commons.data;

  //       queueFind.clear();
  //       for (final v in commons) {
  //         print("MEET AT ${v.data}");
  //         path.add(v.copyWith(state: VertexState.visited));
  //         print(path);
  //       }
  //       if (commons.contains(start) && commons.contains(find)) {
  //         break;
  //       }
  //     }
  //     if (visitedStart.contains(find.data)) {
  //       print("START side reached FIND");
  //       final updatedPath = <Vertex>{};
  //       for (final v in path) {
  //         updatedPath.add(v.copyWith(state: VertexState.visited));
  //       }
  //       path
  //         ..clear()
  //         ..addAll(updatedPath);
  //       yield {...path};

  //       break;
  //     }

  //     if (visitedFind.contains(start.data)) {
  //       final updatedPath = <Vertex>{};
  //       for (final v in path) {
  //         updatedPath.add(v.copyWith(state: VertexState.visited));
  //       }
  //       path
  //         ..clear()
  //         ..addAll(updatedPath);
  //       yield {...path};

  //       break;
  //     }

  //     // yield {...path};
  //     await Future.delayed(const Duration(milliseconds: 300));
  //     if (existsPath(from: meetId, to: find.data, graph: graph)) {
  //       // ✅ ШЛЯХ РЕАЛЬНИЙ
  //       // тут уже можна красиво відновлювати path
  //       break;
  //     } else {
  //       // ❌ ЦЕ ХИБНИЙ MEET
  //       // продовжуємо BFS, шукаємо інший common
  //       continue;
  //     }
  //   }
  // }

  // bool existsPath({
  //   required String from,
  //   required String to,
  //   required Map<String, Vertex> graph,
  // }) {
  //   final queue = Queue<String>();
  //   final visited = <String>{};

  //   print("=== existsPath START ===");
  //   print("FROM: $from  TO: $to");

  //   queue.add(from);
  //   visited.add(from);

  //   while (queue.isNotEmpty) {
  //     print("Queue: $queue");
  //     print("Visited: $visited");

  //     final current = queue.removeFirst();
  //     print("Processing: $current");

  //     if (current == to) {
  //       print("✅ PATH FOUND");
  //       return true;
  //     }

  //     for (final next in graph[current]!.connection) {
  //       print("Check neighbor: $next");

  //       if (!visited.contains(next)) {
  //         print("→ add to queue: $next");
  //         visited.add(next);
  //         queue.add(next);
  //       }
  //     }
  //   }

  //   print("❌ PATH NOT FOUND");
  //   return false;
  // }

  Stream<Set<Vertex>> detourStepsFixed({
    required Vertex start,
    required Vertex find,
    required Map<String, Vertex> graph,
  }) async* {
    final queueStart = Queue<String>();
    final queueFind = Queue<String>();

    final visitedStart = <String>{};
    final visitedFind = <String>{};

    final parentStart = <String, String?>{};
    final parentFind = <String, String?>{};

    print("=== detourStepsFixed START ===");
    print("START: ${start.data}  FIND: ${find.data}");

    queueStart.add(start.data);
    visitedStart.add(start.data);
    parentStart[start.data] = null;

    queueFind.add(find.data);
    visitedFind.add(find.data);
    parentFind[find.data] = null;

    String? meetId = null;
    int step = 0;

    while (queueStart.isNotEmpty && queueFind.isNotEmpty) {
      step++;
      print("\n=== STEP $step ===");
      print("QueueStart: $queueStart");
      print("QueueFind: $queueFind");
      print("VisitedStart: $visitedStart");
      print("VisitedFind: $visitedFind");

      /// --- START SIDE ---
      final s = queueStart.removeFirst();
      print("Process START node: $s");

      for (final n in graph[s]!.connection) {
        print("  START neighbor: $n");

        if (!visitedStart.contains(n)) {
          print("  → add to START queue: $n");
          visitedStart.add(n);
          parentStart[n] = s;
          queueStart.add(n);

          if (visitedFind.contains(n)) {
            print("🔥 MEET at $n from START side");
            meetId = n;
            break;
          }
        }
      }
      if (meetId != null) break;

      /// --- FIND SIDE ---
      final f = queueFind.removeFirst();
      print("Process FIND node: $f");

      for (final n in graph[f]!.connection) {
        print("  FIND neighbor: $n");

        if (!visitedFind.contains(n)) {
          print("  → add to FIND queue: $n");
          visitedFind.add(n);
          parentFind[n] = f;
          queueFind.add(n);

          if (visitedStart.contains(n)) {
            print("🔥 MEET at $n from FIND side");
            meetId = n;
            break;
          }
        }
      }
      if (meetId != null) break;

      await Future.delayed(const Duration(milliseconds: 200));
    }

    if (meetId == null) {
      print("❌ NO MEETING POINT");
      throw("❌ NO MEETING POINT");
    }

    print("=== RECONSTRUCT PATH from meetId=$meetId ===");

    // if (!existsPath(from: meetId, to: find.data, graph: graph)) {
    //   print("❌ existsPath check failed");
    //   return;
    // }

    final path = <String>[];

    /// backtrack START
    String? cur = meetId;
    while (cur != null) {
      path.insert(0, cur);
      print("Backtrack START: $cur");
      cur = parentStart[cur];
    }

    /// forward FIND
    cur = parentFind[meetId];
    while (cur != null) {
      print("Forward FIND: $cur");
      path.add(cur);
      cur = parentFind[cur];
    }

    print("✅ FINAL PATH: $path");

    yield path
        .map((id) => graph[id]!.copyWith(state: VertexState.visited))
        .toSet();
  }
}
