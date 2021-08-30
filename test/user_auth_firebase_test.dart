import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {}

class MockAuthResult extends Mock implements UserCredential {}

void main() async {
  //MockFirebaseAuth _auth = MockFirebaseAuth();
  //BehaviorSubject<MockFirebaseUser> _user = BehaviorSubject<MockFirebaseUser>();
  // when(_auth.authStateChanges()).thenAnswer((_) => _user);
  // AuthTest authService = AuthTest();
  group('User repository test', () {
    // when(_auth.signInWithEmailAndPassword(email: 'email', password: 'password'))
    //     .thenAnswer((_) async {
    //   _user.add(MockFirebaseUser());
    //   return MockAuthResult();
    // });
    test('login with email and password', () async {});
    test('sign out', () async {
      // await authService.signOut(_auth);
    });
  });
}
