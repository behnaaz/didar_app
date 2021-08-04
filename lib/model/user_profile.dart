import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
    final String fullName;
    final List<String> topics;
    //TODO to be completed

    UserProfile({
        //TODO to be completed
        required this.fullName,
        required this.topics
    });

    UserProfile.fromJson(Map<String, Object?> json)
      : this(
          topics: (json['topics']! as List).cast<String>(),
          fullName: json['fullName']! as String,
        //TODO to be completed
        );

  Map<String, Object?> toJson() {
    return {
      'topics': topics,
      'fullName': fullName,
       //TODO to be completed
    };
  }
}