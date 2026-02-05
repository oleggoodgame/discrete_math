import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_math/application/data/entity/graph/graph_entity.dart';
import 'package:discrete_math/application/data/entity/vertex_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User _auth = FirebaseAuth.instance.currentUser!;
  Future<GraphEntity> createGraph({
    required String title,
    required Set<Vertex> data,
  }) async {
    final docRef = _db.collection('accounts').doc(_auth.uid).collection("graphs").doc();

    final graph = GraphEntity(
      id: docRef.id,
      title: title,
      data: data,
      createdAt: DateTime.now(),
    );

    await docRef.set(graph.toMap());
    // print("CREATED");
    return graph;
  }

  Future<GraphEntity> editGraph({
    required Set<Vertex> data,
    required String id,
  }) async {
    final docRef = _db.collection('accounts').doc(_auth.uid).collection("graphs").doc(id);
    await docRef.update({
      'data': data
          .map((v) => v.toMap())
          .toList(), 
    });
    final snapshot = await docRef.get();
    return GraphEntity.fromMap(snapshot.data()!);
  }
}
