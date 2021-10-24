class AvailabilityModel {
  String timeSlot;
  String sessionType;
  String userProfileRef;
  AvailabilityModel({
    required this.timeSlot,
    required this.sessionType,
    required this.userProfileRef,
  });

  Map<String, dynamic> toMap() {
    return {
      'time_slot': timeSlot,
      'session_type': sessionType,
      'user_profile': userProfileRef,
    };
  }

  factory AvailabilityModel.fromMap(Map<String, dynamic> map) {
    return AvailabilityModel(
      timeSlot: map['time_slot'],
      sessionType: map['session_type'],
      userProfileRef: map['user_profile'],
    );
  }
}
