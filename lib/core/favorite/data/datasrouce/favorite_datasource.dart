import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_math/core/graph/data/model/graph_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FavoriteDatasource {
  Future<void> toggle(GraphModel graph);
  Future<Set<String>> loadFavorites();
}

class FavoriteDatasourceImlp implements FavoriteDatasource{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser!;

  CollectionReference<Map<String, dynamic>> get _ref =>
      _db.collection('accounts').doc(user.uid).collection('favorites');

  Future<void> toggle(GraphModel graph) async {
    final docRef = _ref.doc(graph.id);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      await docRef.delete();
    } else {
      await docRef.set({'id': graph.id});
    }
  }

  Future<Set<String>> loadFavorites() async {
    final snapshot = await _ref.get();
    return snapshot.docs
        .map((doc) => doc.id)
        .toSet();
  }
}