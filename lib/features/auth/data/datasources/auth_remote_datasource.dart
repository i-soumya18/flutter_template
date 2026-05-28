import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  const AuthRemoteDataSource.disabled()
      : _firebaseAuth = null,
        _googleSignIn = null;

  final FirebaseAuth? _firebaseAuth;
  final GoogleSignIn? _googleSignIn;

  FirebaseAuth get _auth {
    final auth = _firebaseAuth;
    if (auth == null) {
      throw StateError('Firebase auth is not configured for this template.');
    }
    return auth;
  }

  GoogleSignIn get _google {
    final google = _googleSignIn;
    if (google == null) {
      throw StateError('Google sign-in is not configured for this template.');
    }
    return google;
  }

  Stream<User?> authStateChanges() =>
      _firebaseAuth?.authStateChanges() ?? Stream.value(null);

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(name);
    return credential;
  }

  Future<UserCredential> signInWithGoogle() async {
    final account = await _google.signIn();
    if (account == null) {
      throw StateError('Google sign-in cancelled');
    }
    final auth = await account.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    return _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _google.signOut(),
    ]);
  }

  User? get currentUser => _firebaseAuth?.currentUser;
}
