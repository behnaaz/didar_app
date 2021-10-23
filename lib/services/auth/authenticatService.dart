import 'package:didar_app/model/user_model.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

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
    var credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
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
      await FirestoreServiceDB().addUserProfileData(emptyUser.toJson());
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
