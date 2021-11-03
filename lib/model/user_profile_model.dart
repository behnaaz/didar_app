import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  static final String FIRST_NAME = 'first_name';
  static final String LAST_NAME = 'last_name';
  static final String EMAIL = 'email';
  static final String PHONE_NUMBER = 'phone_number';
  static final String EDU_DEGREE = 'edu_degree';
  static final String BIO = 'bio';
  static final String SOCIAL_LINK = 'social_links';
  static final String SESSION_TOPICS = 'session_topics';
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  /// Educational Degree
  final String eduDegree;
  final String bio;
  final List<dynamic> socialLinks;
  final List sessionTopics;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.eduDegree,
    required this.bio,
    required this.socialLinks,
    required this.sessionTopics,
  });

  factory UserProfile.fromJson(json) {
    return UserProfile(
      firstName: json[FIRST_NAME],
      lastName: json[LAST_NAME],
      email: json[EMAIL],
      phoneNumber: json[PHONE_NUMBER],
      eduDegree: json[EDU_DEGREE],
      bio: json[BIO],
      socialLinks: json[SOCIAL_LINK],
      sessionTopics: json[SESSION_TOPICS],
    );
  }

  Map<String, Object?> toMap() {
    return {
      FIRST_NAME: firstName,
      LAST_NAME: lastName,
      EMAIL: email,
      PHONE_NUMBER: phoneNumber,
      EDU_DEGREE: eduDegree,
      BIO: bio,
      SOCIAL_LINK: socialLinks,
      SESSION_TOPICS: sessionTopics,
    };
  }

  String toString() {
    return toMap().toString();
  }
}
