import 'package:didar_app/model/user_model.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthenticationService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  //NOTE: check IF user is login or not
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

// NOTE : user Instance
  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<User?> signUp({
    // FIXME : this should be first and last name and does't need for sign-up
    required String fullName,
    required String email,
    required String password,
  }) async {
    // Create the Instance od user
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    // TODO : initilize user profile doc for the first time
    UserProfile emptyUser = UserProfile(
      firstName: fullName,
      lastName: fullName,
      email: email,
      phoneNumber: '',
      bio: '',
      eduDegree: '',
      sessionTopics: [],
      socialLinks: [],
    );
    try {
      await FirestoreServiceDB().updateUserData(emptyUser.toJson());
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
