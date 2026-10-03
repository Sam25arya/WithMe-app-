import 'package:firebase_auth/firebase_auth.dart';

/// AuthService handles all Firebase Authentication operations.
///
/// This is the ONLY place in the app that talks to Firebase Auth.
/// Screens call this service — they never touch Firebase directly.
class AuthService {
  // Single shared instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ─────────────────────────────────────────────────────────────────────────
  // Sign IN With Google
  // ─────────────────────────────────────────────────────────────────────────

Future<UserCredential> signInWithGoogle() async {
  try {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    return await _auth.signInWithPopup(googleProvider);
  } on FirebaseAuthException catch (e) {
    throw _friendlyError(e.code);
  }
}




  // ─────────────────────────────────────────────────────────────────────────
  // CURRENT USER
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns the currently signed-in user, or null if not logged in.
  User? get currentUser => _auth.currentUser;

  /// Stream that emits whenever the auth state changes
  /// (user signs in, signs out, or token refreshes).
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ─────────────────────────────────────────────────────────────────────────
  // SIGN UP WITH EMAIL & PASSWORD
  // ─────────────────────────────────────────────────────────────────────────

  /// Creates a new user account with [email] and [password].
  ///
  /// Returns the [UserCredential] on success.
  /// Throws a [String] error message on failure.
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _friendlyError(e.code);
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SIGN IN WITH EMAIL & PASSWORD
  // ─────────────────────────────────────────────────────────────────────────

  /// Signs in an existing user with [email] and [password].
  ///
  /// Returns the [UserCredential] on success.
  /// Throws a [String] error message on failure.
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _friendlyError(e.code);
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SIGN OUT
  // ─────────────────────────────────────────────────────────────────────────

  /// Signs the current user out of the app.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PASSWORD RESET
  // ─────────────────────────────────────────────────────────────────────────

  /// Sends a password reset email to [email].
  ///
  /// Throws a [String] error message on failure.
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _friendlyError(e.code);
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // UPDATE DISPLAY NAME
  // ─────────────────────────────────────────────────────────────────────────

  /// Updates the display name shown on the user's Firebase profile.
  Future<void> updateDisplayName(String name) async {
    await _auth.currentUser?.updateDisplayName(name);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // HELPER: Human-readable error messages
  // ─────────────────────────────────────────────────────────────────────────

  /// Converts Firebase error codes into friendly messages the user can understand.
  String _friendlyError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Try logging in instead.';
      case 'invalid-email':
        return 'That email address doesn\'t look right. Please check it.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'user-not-found':
        return 'No account found with that email. Try signing up first.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Incorrect email or password. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait a moment and try again.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      default:
        return 'Something went wrong. Please try again. ($code)';
    }
  }
}
