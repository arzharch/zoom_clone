import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';
import 'package:logger/logger.dart'; // Add logger

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger(); // Initialize logger
  // Create a persistent instance of GoogleSignIn.
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  /// If [forceAccountSelection] is true, this will sign out and disconnect
  /// the current Google account so that the account chooser is displayed.
  Future<bool> signInWithGoogle(
    BuildContext context, {
    bool forceAccountSelection = false,
  }) async {
    bool res = false;
    try {
      if (forceAccountSelection) {
        // Clear any cached account information.
        await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If the user cancels the sign in process, googleUser will be null.
      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Optionally, you can add new user logic here.
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(
          context,
          e.message ?? "An error occurred during Google sign-in.",
        );
      }
      res = false;
    } catch (e) {
      _logger.e("Unexpected error during Google sign in: $e");
      if (context.mounted) {
        showSnackBar(
          context,
          "Unexpected error occurred during Google sign in.",
        );
      }
      res = false;
    }
    return res;
  }

  void signOut() async {
    try {
      await _auth.signOut();
      // Also sign out from Google to clear the cached account.
      await _googleSignIn.signOut();
      _logger.i("User signed out successfully.");
    } catch (e) {
      _logger.e("Error signing out: $e");
    }
  }
}
