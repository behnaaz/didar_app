import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/session_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FBUserSessionService {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference
  final CollectionReference _sessionOfUser = FirebaseFirestore.instance.collection('sessions_of_user');

  /// Get the stream snapshot of my user session List
  Stream<DocumentSnapshot<Object?>> get sessionList {
    return _sessionOfUser.doc(_firebaseAuth.currentUser!.uid).snapshots();
  }

  /// update the session document or create for the first time
  Future sessionUpdate(
    SessionModel session
  ) async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _sessionOfUser.doc(uid).set({
      'sessionList': FieldValue.arrayUnion([
        session.toMap()
          
        ,
      ])
    }, SetOptions(merge: true));
  }

  Future deleteSession(session) async {
    String uid = _firebaseAuth.currentUser!.uid;
    try {
      return await _sessionOfUser.doc(uid).update(
        {
          'sessionList': FieldValue.arrayRemove([session])
        },
      ).then((value) => print('dleted'));
    } catch (e) {
      print('error: try to remove available time');
    }
  }
}
