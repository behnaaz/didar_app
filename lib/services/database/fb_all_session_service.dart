
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/all_session_model.dart';



class FBAllSessionTypeService {
  final DocumentReference _allSessionTypeDoc = FirebaseFirestore.instance.collection('session_types').doc('B47yMw2TcyCmDndeQI25');


AllSessionModel _allSessionFromSnapshot(DocumentSnapshot snapshot) {
    return AllSessionModel.fromJson(snapshot.data());
  }

 
  /// Get snapshot of all Session Types
  Future<AllSessionModel> get allSessionsFuture {
    return _allSessionTypeDoc.snapshots().map(_allSessionFromSnapshot).first;
  }
}
