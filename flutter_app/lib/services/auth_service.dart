import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Logger logger = Logger();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Stream of authentication changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Email/Password Sign Up
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i('User signed up: ${credential.user?.email}');
      return credential;
    } on FirebaseAuthException catch (e) {
      logger.e('Sign up error: ${e.message}');
      rethrow;
    }
  }

  // Email/Password Sign In
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i('User signed in: ${credential.user?.email}');
      return credential;
    } on FirebaseAuthException catch (e) {
      logger.e('Sign in error: ${e.message}');
      rethrow;
    }
  }

  // Google Sign In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      logger.i('User signed in with Google: ${userCredential.user?.email}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      logger.e('Google sign in error: ${e.message}');
      rethrow;
    }
  }

  // Send Email Verification
  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
      logger.i('Email verification sent');
    } on FirebaseAuthException catch (e) {
      logger.e('Email verification error: ${e.message}');
      rethrow;
    }
  }

  // Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      logger.i('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      logger.e('Password reset error: ${e.message}');
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      logger.i('User signed out');
    } catch (e) {
      logger.e('Sign out error: $e');
      rethrow;
    }
  }

  // Update User Profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      await currentUser?.updateProfile(
        displayName: displayName,
        photoURL: photoUrl,
      );
      logger.i('User profile updated');
    } on FirebaseAuthException catch (e) {
      logger.e('Profile update error: ${e.message}');
      rethrow;
    }
  }

  // Change Password
  Future<void> changePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
      logger.i('Password changed');
    } on FirebaseAuthException catch (e) {
      logger.e('Password change error: ${e.message}');
      rethrow;
    }
  }
}
