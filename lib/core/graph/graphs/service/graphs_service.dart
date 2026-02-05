import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_math/application/data/entity/graph/graph_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GraphsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User _auth = FirebaseAuth.instance.currentUser!;

  Future<List<GraphEntity>> getAllGraphs() async {
    final snapshot = await _db
        .collection('accounts')
        .doc(_auth.uid)
        .collection("graphs")
        .orderBy('createdAt', descending: true)
        .get();
    print(snapshot.size);
    return snapshot.docs.map((doc) => GraphEntity.fromMap(doc.data())).toList();
  }

  Future<void> deleteGraph(GraphEntity graph) async {
    final snapshot = await _db
        .collection('accounts')
        .doc(_auth.uid)
        .collection("graphs")
        .doc(graph.id);
    await snapshot.delete();
  }
}
