import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<void> signOut();
  Future<User> currentUser();
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password);
  Future<void> forgotPassword(String email);
  Stream<User> get onAuthChange;
  Future<User> signInAnno();
  Future<void> deleteUser();
}

class User {
  final String uid;
  final String email;
  User({this.uid, this.email});
}

class Auth extends AuthBase {
  final _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  User _userFromFirebase(user) {
    if (user == null) {
      return null;
    } else {
      return User(uid: user.uid, email: user.email);
    }
  }

  @override
  Future<User> currentUser() async {
    final user = _auth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<void> deleteUser() async {
    return _auth.currentUser.delete();
  }

  @override
  Stream<User> get onAuthChange {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User> signInAnno() async {
    final authResult = await _auth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<User> signIn(String email, String password) async {
    final userCredentail = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print(userCredentail.user.uid);
    return _userFromFirebase(userCredentail.user);
  }

  @override
  Future<User> signUp(String email, String password) async {
    UserCredential userCredentail = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(userCredentail.user);
  }

  Future<void> logOut() async {
    print('object');
  }
}
// 56:84:AA:EC:E4:1E:81:B5:8C:56:6F:BC:90:E9:9A:FE:43:DA:7B:5A:14:84:7E:0C:53:71:CB:A6:A6:EF:6E:23
