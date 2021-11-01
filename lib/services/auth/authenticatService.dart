import 'package:didar_app/model/user_model.dart';
import 'package:didar_app/services/proxy/proxy_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:logger/logger.dart';

final Logger logger = Logger();

class AuthenticationService {
  final auth.FirebaseAuth _firebaseAuth;
  final ProxyService _proxyService;
  AuthenticationService(this._proxyService, this._firebaseAuth);

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
    logger.i("isFallback " + _fallback.toString());
    return _fallback;
  }

  void enableFallback() {
    logger.i("fallback was " + _fallback.toString());
    _fallback = true;
    logger.i("Setting fallback to true");
  }

  User? get currentUser {
    _currentUser ??= _userFromFirebase(_firebaseAuth.currentUser);
    logger.i("currentuser " +
        (_currentUser == null ? "null" : _currentUser!.asString()));
    return _currentUser;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    logger.d("singining in for " + email);
    try {
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      logger.d("Credentials retrieved for " + email);
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

/** 
 * TODO: This part should be moved to firestoreService
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
*/
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    _currentUser = null;
    return await _firebaseAuth.signOut();
  }
}
