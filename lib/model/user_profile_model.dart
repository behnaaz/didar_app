import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  static final String FIRST_NAME = 'first_name';
//TODO rest as above
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
      lastName: json["last_name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      eduDegree: json["edu_degree"],
      bio: json["bio"],
      socialLinks: json["social_links"],
      sessionTopics: json["session_topics"],
    );
  }

  Map<String, Object?> toMap() {
    return {
      FIRST_NAME: firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'edu_degree': eduDegree,
      'bio': bio,
      'social_links': socialLinks,
      'session_topics': sessionTopics,
    };
  }

  String toString() {
    return toMap().toString();
  }
}
