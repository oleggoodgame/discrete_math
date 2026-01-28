import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_math/application/data/entity/graph/graph_entity.dart';

class GraphsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<GraphEntity>> getAllGraphs() async {
    final snapshot = await _db.collection('graphs').orderBy('createdAt').get();
    print(snapshot.size);
    return snapshot.docs.map((doc) => GraphEntity.fromMap(doc.data())).toList();
  }
}
