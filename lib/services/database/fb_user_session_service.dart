import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/session_model.dart';
import 'package:didar_app/services/auth/authenticatService.dart';

class FBUserSessionService {
  final AuthenticationService _authService;
  FBUserSessionService(this._authService);
 

  /// Collection Reference
  final CollectionReference _sessionOfUser = FirebaseFirestore.instance.collection('sessions_of_user');


  /// Get the stream snapshot of my user session List
  Stream<DocumentSnapshot<Object?>> get sessionList {
    return _sessionOfUser.doc(_authService.currentUser!.uid).snapshots();
  }

  /// update the session document or create for the first time
  Future sessionUpdate(SessionModel session) async {
    String uid = _authService.currentUser!.uid;
    return await _sessionOfUser.doc(uid).set({
      'sessionList': FieldValue.arrayUnion([
        session.toMap(),
      ])
    }, SetOptions(merge: true));
  }

  Future deleteSession(session) async {
    String uid = _authService.currentUser!.uid;
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
