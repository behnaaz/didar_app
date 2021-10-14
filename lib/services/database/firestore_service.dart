import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;


class FirestoreServiceDB {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference of [Users_profile]
  final CollectionReference _userProfilesCollection = FirebaseFirestore.instance.collection('user_profile');

  /// initial user profile data >> I use it in register >> AuthenticationService.signUp
  Future addUserProfileData(userData) async {
     String uid = _firebaseAuth.currentUser!.uid;
    return await _userProfilesCollection.doc(uid).set(userData);
  }

  /// Update UserDate
  Future updateUserData(userData) async {
     String uid = _firebaseAuth.currentUser!.uid;
    return await _userProfilesCollection.doc(uid).set(userData, SetOptions(merge: true));
  }
  /// Update Session_topic
  Future updateSessionTopic(List<String> sessionList) async {
     String uid = _firebaseAuth.currentUser!.uid;
    return await _userProfilesCollection.doc(uid).set({'session_topics' : sessionList }, SetOptions(merge: true));
  }

  /// add new social links
  Future addNewSocialLink(String label, String link, List<dynamic> socialList) async {
     String uid = _firebaseAuth.currentUser!.uid;
    bool edit = false;
    for (var i = 0; i < socialList.length; i++) {
      if (socialList[i].containsKey(label)) {
        edit = true;
        socialList[i][label] = link;
        break;
      }
    }
if(!edit){
      socialList.add({label: link});
}
    return await _userProfilesCollection.doc(uid).update({
      'social_links': socialList,
    });
  }

// Get the stream snapshot of user profile
  Stream<DocumentSnapshot> get userProfile {
    return _userProfilesCollection.doc(_firebaseAuth.currentUser!.uid).snapshots();
  }

}
