import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FirestoreServiceDB {
  final  String? uid;
  FirestoreServiceDB( {this.uid});

  /// Collection Reference of [Users_profile]
  final CollectionReference _userProfilesCollection =
      FirebaseFirestore.instance.collection('user_profile');

  /// Update UserDate
  Future updateUserData({
    required String fullName,
    required String email,
    required int phoneNumber,
    required int age,
  }) async {
    return await _userProfilesCollection.doc(uid).set({
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'age': age,
    });
  }

// Get the stream snapshot of user profile
  Stream<DocumentSnapshot> get userProfile {
    
    return _userProfilesCollection.doc("cYFuCBGequbrVCzUeQaC3FkU2Kz1").snapshots();
  }
}
