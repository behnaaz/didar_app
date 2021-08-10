import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:didar_app/model/user_profile_model.dart';

class UserProfileDao {
    CollectionReference users = FirebaseFirestore.instance.collection('user_profiles');

    Future<void> addUserProfile(final UserProfile userProfile) {
      // TODO database logic goes here reference: https://firebase.flutter.dev/docs/firestore/usage
      throw Exception('Not implemented yet!');
    }


}