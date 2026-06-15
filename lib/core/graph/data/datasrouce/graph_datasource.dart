import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_math/core/graph/data/model/graph_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class GraphDatasource {
  Future<List<GraphModel>> getAllGraphs();
  Future<void> deleteGraph(GraphModel graph);
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

}
