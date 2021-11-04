class AvailabilityModel {
  static final String TIME_SLOT = 'time_slot';
  static final String SESSION_TYPE = 'session_type';
  static final String USER_PROFILE_REF = 'user_profile';

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
      TIME_SLOT: timeSlot,
      SESSION_TYPE: sessionType,
      USER_PROFILE_REF: userProfileRef,
    };
  }

  factory AvailabilityModel.fromMap( map) {
    return AvailabilityModel(
      timeSlot: map[TIME_SLOT],
      sessionType: map[SESSION_TYPE],
      userProfileRef: map[USER_PROFILE_REF],
    );
  }
}
