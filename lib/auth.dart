import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User> user;

  AuthService() {
    user = _auth.authStateChanges();
  }

  Future<UserCredential> signInWithGoogle() async{
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // obtain auth details
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // create new credentials
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, 
      idToken: googleAuth.idToken
    );
    updateUserData();
    // return User 
    return await _auth.signInWithCredential(credential);
  }

  Future<User> getUser() async {
    return _auth.currentUser;
  }

  void updateUserData() async {
    var user = _auth.currentUser;
  }

  void signOut(){
    _auth.signOut();
  }

}

final AuthService authService = AuthService();