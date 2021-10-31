import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/services/auth/authenticatService.dart';

class FirestoreServiceDB {
  final AuthenticationService _authService;
  FirestoreServiceDB(this._authService);
  String get uid => _authService.currentUser!.uid;

  final CollectionReference _userProfilesCollection =
      FirebaseFirestore.instance.collection('user_profile');

  /// initial user profile data >> I use it in register >> AuthenticationService.signUp
  Future addUserProfileData(userData) async {
    return await _userProfilesCollection.doc(uid).set(userData);
  }

  /// Update UserDate
  Future updateUserData(userData) async {
    return await _userProfilesCollection
        .doc(uid)
        .set(userData, SetOptions(merge: true));
  }

  /// Update Session_topic
  Future updateSessionTopic(List<String> sessionList) async {
    return await _userProfilesCollection
        .doc(uid)
        .set({'session_topics': sessionList}, SetOptions(merge: true));
  }

  /// add new social links
  Future addNewSocialLink(
      String label, String link, List<dynamic> socialList) async {
    bool edit = false;
    for (var i = 0; i < socialList.length; i++) {
      if (socialList[i].containsKey(label)) {
        edit = true;
        socialList[i][label] = link;
        break;
      }
    }
    if (!edit) {
      socialList.add({label: link});
    }
    return await _userProfilesCollection.doc(uid).update({
      'social_links': socialList,
    });
  }

  Future<UserProfile> get userProfile {
    return _userProfilesCollection.doc(uid).get().then((value) =>
        UserProfile.fromJson(value.data())); //TODO if null TODO Options for get
  }
}
