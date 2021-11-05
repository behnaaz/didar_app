import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/session_model.dart';
import 'package:didar_app/services/auth/authenticatService.dart';

class FBUserSessionService {
  final AuthenticationService _authService;
  FBUserSessionService(this._authService);

  /// Collection Reference
  final CollectionReference _sessionOfUser = FirebaseFirestore.instance.collection('sessions_of_user');

  SessionModel _sessionFromSnapshot(map) {
    return SessionModel.fromJson(map);
  }

  /// Get the stream snapshot of my user session List
  Stream<List<SessionModel>> get sessionList {
    return _sessionOfUser.doc(_authService.currentUser!.uid).snapshots().map((event) {
      List _rawList = (event['sessionList']);
      List<SessionModel> finalList = [];
      _rawList.forEach((element) {
        finalList.add(_sessionFromSnapshot(element));
      });
      return finalList;
    });
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

  Future deleteSession(SessionModel session) async {
    String uid = _authService.currentUser!.uid;
    try {
      return await _sessionOfUser.doc(uid).update(
        {
          'sessionList': FieldValue.arrayRemove([session.toMap()])
        },
      ).then((value) => print('dleted'));
    } catch (e) {
      print('error: try to remove available time');
    }
  }
}
