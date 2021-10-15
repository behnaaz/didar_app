import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/availability_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;


// session_type
// time_slot_end
// time_slot_start
// user_profile (ref)

class FBUserSessionService {
  // NOTE : AuthService Provider
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  /// Collection Reference
  final CollectionReference _sessionOfUser = FirebaseFirestore.instance.collection('user_availability');

  
  
  Future updateAvailableTime({
    required String type,
    required String audience,
    required String duration,
    required String cap,
    required String price,
    required String info,
    required String color,
  }) async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _sessionOfUser.doc(uid).update(
      {
        'sessionList': FieldValue.arrayUnion([
          {
            'session_type': type,
            'audience': audience,
            'duration': duration,
            'capacity': cap,
            'price': price,
            'info': info,
            'color': color,
          },
        ])
      },
    );
  }

  
  Stream<DocumentSnapshot<Object?>> get availability {
    return _sessionOfUser.doc(_firebaseAuth.currentUser!.uid).snapshots();
  }
}
