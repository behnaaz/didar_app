import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FBUserSessionService {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference
  final CollectionReference _sessionOfUser = FirebaseFirestore.instance.collection('sessions_of_user');

  /// initial user profile data >> I use it in register >> AuthenticationService.signUp
  // Future addUserProfileData(userData) async {
  //   String uid = _firebaseAuth.currentUser!.uid;
  //   return await _userProfilesCollection.doc(uid).set(userData);
  // }

  /// Update UserDate
  Future sessionUpdate() async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _sessionOfUser.doc(uid).set({
      'sessionList': [
        'موسیقی',
        'روانشناسی',
      ]
    }, SetOptions(merge: true));
  }

  /// Get the stream snapshot of my user session List
  Stream<DocumentSnapshot<Object?>> get sessionList {
    return _sessionOfUser.doc(_firebaseAuth.currentUser!.uid).snapshots();
  }
}
