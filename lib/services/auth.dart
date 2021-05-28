import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // obtain auth details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // create new credentials
    FirebaseUser result = await _auth.signInWithGoogle(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    updateUserData(result);
    // return User
    return result;
  }

  /// Anonymous Firebase login
  Future<FirebaseUser> anonLogin() async {
    FirebaseUser result = await _auth.signInAnonymously();

    updateUserData(result);
    return result;
  }

  Future<FirebaseUser> getUser() async {
    return _auth.currentUser();
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference reportRef = _db.collection('userInfo').doc(user.uid);
    createInitialFridge(user);
    return reportRef.set({'uid': user.uid, 'lastActivity': DateTime.now()},
        SetOptions(merge: true));
  }

  void createInitialFridge(FirebaseUser user) async {
    DocumentReference fridgeRef = _db.collection('fridge').doc(user.uid);
    return fridgeRef.set({'createdBy': user.uid}, SetOptions(merge: true));
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}

final AuthService authService = AuthService();
