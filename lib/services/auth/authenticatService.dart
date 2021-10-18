import 'package:didar_app/model/user_model.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:logger/logger.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Logger logger = Logger();

class AuthenticationService {
  AuthenticationService._privateConstructor();
  static final AuthenticationService instance =
      AuthenticationService._privateConstructor();
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  bool isAuthenticated() {
    return currentUser != null;
  }

  //NOTE: check IF user is login or not
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  User? get currentUser {
    return _userFromFirebase(_firebaseAuth.currentUser);
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(credential.user);
    } on Exception catch (e) {
      var user = await signInWorkaround(email);
      logger.e("Exception is caught: ", e);
      return user;
    }
  }

  Future<User>? signInWorkaround(email) async {
    var url = Uri.http('216.137.187.176:8080', '/login', {'key': email});
    logger.d("Going to login via proxy " + email + " from " + url.path);

    // Await the http get response, then decode the json-formatted response.
    var response;

    try {
      response =
          await http.get(url, headers: {'Access-Control-Allow-Origin': '*'});
      logger.d("response:", response);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, String>;
        var email = jsonResponse['Email'];
        var uid = jsonResponse['UID'];
        print('User: $email $uid.');
        return User(uid!, email!);
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return Future.error(
            'Request failed with status: ${response.statusCode}.');
      }
    } on Exception catch (e) {
      logger.e("ERROR: ", e);
      return Future.error(e);
    }
  }

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    // Create the Instance od user
    var credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    
    UserProfile emptyUser = UserProfile(
      firstName: '',
      lastName: '',
      email: email,
      phoneNumber: '',
      bio: '',
      eduDegree: '',
      sessionTopics: [],
      socialLinks: [],
    );
    try {
      await FirestoreServiceDB().addUserProfileData(emptyUser.toMap());
    } catch (e) {
      print(
          "authenticateService : I the credential in null, userInstance has been not created");
    }

    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
