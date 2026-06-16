import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_math/core/graph/data/model/graph_model.dart';
import 'package:discrete_math/core/graph/data/model/vertex_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class GraphDatasource {
  Future<List<GraphModel>> getAllGraphs();
  Future<void> deleteGraph(GraphModel graph);
  Future<GraphModel> createGraph({
    required String title,
    required Set<VertexModel> data,
  });
  Future<GraphModel> editGraph({
    required Set<VertexModel> data,
    required String id,
  });
}

class GraphDatasourceImpl implements GraphDatasource {
  @override
  Future<void> deleteGraph(GraphModel graph) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    final User auth = FirebaseAuth.instance.currentUser!;

    final doc = db
        .collection('accounts')
        .doc(auth.uid)
        .collection("graphs")
        .doc(graph.id);
    await doc.delete();
  }

  @override
  Future<List<GraphModel>> getAllGraphs() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    final User auth = FirebaseAuth.instance.currentUser!;

    final snapshot = await db
        .collection('accounts')
        .doc(auth.uid)
        .collection("graphs")
        .orderBy('createdAt', descending: true)
        .get();
    print(snapshot.size);
    return snapshot.docs.map((doc) => GraphModel.fromMap(doc.data())).toList();
  }

  @override
  Future<GraphModel> createGraph({
    required String title,
    required Set<VertexModel> data,
  }) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser!;

    final docRef = db
        .collection('accounts')
        .doc(auth.uid)
        .collection("graphs")
        .doc();

    final graph = GraphModel(
      id: docRef.id,
      title: title,
      data: data,
      createdAt: DateTime.now(),
    );

    await docRef.set(graph.toMap());
    // print("CREATED");
    return graph;
  }

  @override
  Future<GraphModel> editGraph({
    required Set<VertexModel> data,
    required String id,
  }) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final User auth = FirebaseAuth.instance.currentUser!;

    final docRef = db
        .collection('accounts')
        .doc(auth.uid)
        .collection("graphs")
        .doc(id);
    await docRef.update({'data': data.map((v) => v.toMap()).toList()});
    final snapshot = await docRef.get();
    return GraphModel.fromMap(snapshot.data()!);
  }
}
