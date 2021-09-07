// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;

// class FSProfileServiceDB {
// // NOTE : AuthService Provider
//   final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

//   /// Collection Reference of [Users_profile]
//   final CollectionReference _userProfilesCollection =
//       FirebaseFirestore.instance.collection('user_profile');

// /// provide all the filed in profile document
//   Stream<DocumentSnapshot> get userProfile {
//     return _userProfilesCollection
//         .doc(_firebaseAuth.currentUser!.uid)
//         .snapshots();
  
//   }

//   /// Future add new field or update exiting one with merge 
  

//   /// Update UserDate
//   Future updateUserData({
//     required String fullName,
//     required String email,
//     required String phoneNumber,
//     required int age,
//   }) async {
//     final String uid = _firebaseAuth.currentUser!.uid;
//     return await _userProfilesCollection.doc(uid).set({
//       'full_name': fullName,
//       'email': email,
//       'phone_number': phoneNumber,
//       'age': age,
//     });
//   }

//   // mock
//   Future updateBio() async {
//     final String uid = _firebaseAuth.currentUser!.uid;
//     return await _userProfilesCollection.doc(uid).set({
//       'full_name': 'sajjad az',
//       'email': 'msbaa1998@gmail.com',
//       'phone_number': '09121212',
//       'age': 12,
//     });
//   }
// }
