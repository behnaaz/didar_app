import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

class FBAvailabilityServices {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference of [availability] inside [Users_profile] collection
  final CollectionReference _userProfilesCollection = FirebaseFirestore.instance.collection('user_profile');

  // Get the stream snapshot of user profile availability time
  Stream<QuerySnapshot> get availability {
    return _userProfilesCollection.doc(_firebaseAuth.currentUser!.uid).collection('availability').get().asStream();
  }

  /// initial user profile data >> I use it in register >> AuthenticationService.signUp
  Future initAvailability() async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _userProfilesCollection.doc(uid).collection('availability').doc().set({'alaki': 'asd'});
  }
}
