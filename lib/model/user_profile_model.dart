import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  final String fullName;
  final String email;
  final int phoneNumber;
  final int age;

  UserProfile({
    //TODO : Profile property should be completed
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.age,
  });

  factory UserProfile.fromJson(final json) {
    return UserProfile(
      fullName: json["name"],
      email: json["id"],
      phoneNumber: json["symbol"],
      age: json["currency"],
    );
  }
}
