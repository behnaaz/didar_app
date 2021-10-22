import 'package:cloud_firestore/cloud_firestore.dart';

class FBAllSessionTypeService {
  final DocumentReference _allSessionTypeDoc = FirebaseFirestore.instance.collection('session_types').doc('B47yMw2TcyCmDndeQI25');

  /// Get snapshot of all Session Types
   Future<DocumentSnapshot<Object?>> get  allSessionsType {
    return _allSessionTypeDoc.get();
  }
}
