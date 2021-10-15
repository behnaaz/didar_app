import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FBUserSessionService {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference
  final CollectionReference _sessionOfUser = FirebaseFirestore.instance.collection('sessions_of_user');

  /// update the session document or create for the first time
  Future sessionUpdate({
    required String type,
    required String audience,
    required String duration,
    required String cap,
    required String price,
    required String info,
    required String color,
  }) async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _sessionOfUser.doc(uid).set({
      'sessionList': FieldValue.arrayUnion([
        {
          'session_type': type,
          'audience': audience,
          'duration': duration,
          'capacity': cap,
          'price': price,
          'info': info,
          'color': color,
        },
      ])
    }, SetOptions(merge: true));
  }

  /// Get the stream snapshot of my user session List
  Stream<DocumentSnapshot<Object?>> get sessionList {
    return _sessionOfUser.doc(_firebaseAuth.currentUser!.uid).snapshots();
  }
}
