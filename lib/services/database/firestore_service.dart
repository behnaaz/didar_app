import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FirestoreServiceDB {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference of [Users_profile]
  final CollectionReference _userProfilesCollection =
      FirebaseFirestore.instance.collection('user_profile');

  /// Update UserDate
  Future updateUserData(userData) async {
    final String uid = _firebaseAuth.currentUser!.uid;
    return await _userProfilesCollection.doc(uid).set(userData);
  }

// Get the stream snapshot of user profile
  Stream<DocumentSnapshot> get userProfile {
    return _userProfilesCollection
        .doc(_firebaseAuth.currentUser!.uid)
        .snapshots();
  }

  // mock
  // UserProfile mockU = UserProfile(
  //     firstName: 'firstName',
  //     lastName: 'lastName',
  //     email: 'email',
  //     phoneNumber: 'phoneNumber',
  //     eduDegree: '',
  //     bio: '',
  //     socialLinks: [],
  //     sessionTopics: []);
  // Future mockUserData() async {
  //   final String uid = _firebaseAuth.currentUser!.uid;
  //   return await _userProfilesCollection.doc('uid').set(this.mockU.toJson());
  // }
}
