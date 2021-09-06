import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FirestoreServiceDB {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference of [Users_profile]
  final CollectionReference _userProfilesCollection =
      FirebaseFirestore.instance.collection('user_profile');

  /// Update UserDate
  Future updateUserData({
    required String fullName,
    required String email,
    required String phoneNumber,
    required int age,
  }) async {
    final String uid = _firebaseAuth.currentUser!.uid;
    return await _userProfilesCollection.doc(uid).set({
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'age': age,
    });
  }

// Get the stream snapshot of user profile
  Stream<DocumentSnapshot> get userProfile {
    return _userProfilesCollection
        .doc(_firebaseAuth.currentUser!.uid)
        .snapshots();
  }

  // mock

  String userID() => _firebaseAuth.currentUser!.uid;
  Stream<DocumentSnapshot> get mockUser {
    return _userProfilesCollection
        .doc('d5Uh8J7aF3YCwZo8w3lIynVmSqo2')
        .snapshots();
  }
  
}
