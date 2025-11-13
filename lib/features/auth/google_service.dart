import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService2 {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      // Start authentication
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      // Get the idToken from googleUser.authentication
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      if (idToken == null) {
        print("Google Sign‑In failed: no idToken");
        return null;
      }

      // Create credential for Firebase using only idToken (accessToken may be null/unavailable)
      final credential = GoogleAuthProvider.credential(idToken: idToken);

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      print("Google Sign‑In success: ${userCredential.user?.displayName}");
      return userCredential;
    } catch (e) {
      print("Google Sign‑In error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
