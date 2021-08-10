import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FirestoreService {
  final String uid;
  FirestoreService(this.uid);

  /// Collection Reference of [Users_profile]
  CollectionReference userProfilesCollection =
      FirebaseFirestore.instance.collection('user_profile');

  /// Update UserDate
  Future updateUserData({
    
    required String fullName,
    required String email,
    required int phoneNumber,
    required int age,
  }) async {
    return await userProfilesCollection.doc(uid).set({
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'age': age,
    });
  }
}
