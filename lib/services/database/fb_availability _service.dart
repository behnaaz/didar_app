import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/availability_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

// session_type
// time_slot
// user_profile (ref)

class FBAvailableTimeService {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference
  final CollectionReference _sessionOfUser = FirebaseFirestore.instance.collection('user_availability');

  Future updateAvailableTime({
    required String timeSlot,
    String? sessionType,
  }) async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _sessionOfUser.doc(uid).set({
      'available_List': FieldValue.arrayUnion([
        {
          'time_slot': timeSlot,
          'session_type': sessionType ?? '',
          'user_profile': '/user_profile/${uid}',
        },
      ])
    }, SetOptions(merge: true));
  }

  Future deleteAvailableTime({required String timeSlot, required String type}) async {
    String uid = _firebaseAuth.currentUser!.uid;
    try {
      return await _sessionOfUser.doc(uid).update(
        {
          'available_List': FieldValue.arrayRemove([
            {
              'time_slot': timeSlot,
              'session_type': type,
              'user_profile': '/user_profile/${uid}',
            },
          ])
        },
      );
    } catch (e) {
      print('error: try to remove available time');
    }
  }

  Stream<DocumentSnapshot<Object?>> get availability {
    return _sessionOfUser.doc(_firebaseAuth.currentUser!.uid).snapshots();
  }
}
