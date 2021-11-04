import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/model/availability_model.dart';
import 'package:didar_app/services/auth/authenticatService.dart';

class FBAvailableTimeService {
   final AuthenticationService _authService;
  FBAvailableTimeService(this._authService);
  static final String AVAILABLE_LIST = 'available_List';
  

  /// Collection Reference
  final CollectionReference _sessionOfUser = FirebaseFirestore.instance.collection('user_availability');

  Future updateAvailableTime({
    required String timeSlot,
    String? sessionType,
  }) async {
    String uid = _authService.currentUser!.uid;
    AvailabilityModel item = AvailabilityModel(
      timeSlot: timeSlot,
      sessionType: sessionType ?? '',
      userProfileRef: '/user_profile/${uid}',
    );
    return await _sessionOfUser.doc(uid).set({
      AVAILABLE_LIST: FieldValue.arrayUnion([item.toMap()])
    }, SetOptions(merge: true));
  }

  Future deleteAvailableTime({required String timeSlot, required String type}) async {
    String uid = _authService.currentUser!.uid;
    AvailabilityModel item = AvailabilityModel(
      timeSlot: timeSlot,
      sessionType: type,
      userProfileRef: '/user_profile/${uid}',
    );
    try {
      return await _sessionOfUser.doc(uid).update(
        {
          AVAILABLE_LIST: FieldValue.arrayRemove([item.toMap()])
        },
      );
    } catch (e) {
      print('error: try to remove available time');
    }
  }

  AvailabilityModel _availabilityFromSnapshot(map) {
    return AvailabilityModel.fromMap(map);
  }

  Stream<List<AvailabilityModel>> get availability {
    return _sessionOfUser.doc(_authService.currentUser!.uid).snapshots().map((event) {
      List _rawList = (event['available_List']);
      List<AvailabilityModel> finalList = [];
      _rawList.forEach((element) {
        finalList.add(_availabilityFromSnapshot(element));
      });
      return finalList;
    });
  }
}
