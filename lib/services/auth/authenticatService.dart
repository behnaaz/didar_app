import 'package:didar_app/model/user_model.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:didar_app/services/proxy/proxy_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:logger/logger.dart';

final Logger logger = Logger();

class AuthenticationService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final ProxyService _proxyService;
  final FirestoreServiceDB _firestoreService;
  AuthenticationService(this._firestoreService, this._proxyService);

  bool _fallback = false;
  static User? _currentUser;

  static User? authenticatedUser() {
    return _currentUser;
  }

  bool isAuthenticated() {
    return currentUser != null;
  }

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  bool get isFallback {
    logger.i("isFallback {0}", _fallback);
    return _fallback;
  }

  void enableFallback() {
    logger.i("fallback was {0}", _fallback);
    _fallback = true;
    logger.i("Setting fallback to true");
  }

  User? get currentUser {
    _currentUser ??= _userFromFirebase(_firebaseAuth.currentUser);
    logger.i("currentuser {0}", _currentUser);
    return _currentUser;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    logger.i("singining in for {0}", email);
    try {
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(credential.user);
    } on Exception catch (e) {
      enableFallback();
      var user = await _proxyService.login(email);
      logger.e("Exception is caught: ", e);
      return user;
    }
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
      await _firestoreService.addUserProfileData(emptyUser.toMap());
    } catch (e) {
      logger.e(
          "authenticateService : I the credential in null, userInstance has been not created");
    }

    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    _currentUser = null;
    return await _firebaseAuth.signOut();
  }
}
