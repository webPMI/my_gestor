import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../config/backend_config.dart';

class AuthService extends ChangeNotifier {
  AuthService._();

  static final AuthService instance = AuthService._();

  StreamSubscription<firebase_auth.User?>? _authSubscription;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _googleSubscription;
  firebase_auth.User? _currentUser;
  bool _initialized = false;

  firebase_auth.User? get currentUser => _currentUser;
  bool get isSignedIn => _currentUser != null;
  bool get firebaseEnabled =>
      BackendConfig.firebaseOptions != null || Firebase.apps.isNotEmpty;
  bool get supabaseEnabled => BackendConfig.hasSupabase;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    _initialized = true;

    if (BackendConfig.hasGoogleClientId) {
      await GoogleSignIn.instance.initialize(
        clientId: BackendConfig.googleClientId,
      );

      _googleSubscription = GoogleSignIn.instance.authenticationEvents.listen((
        event,
      ) {
        if (event case GoogleSignInAuthenticationEventSignIn(:final user)) {
          unawaited(_syncGoogleUser(user));
        }
      });
    }

    if (firebaseEnabled && Firebase.apps.isNotEmpty) {
      _currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
      _authSubscription = firebase_auth.FirebaseAuth.instance
          .authStateChanges()
          .listen((user) {
            _currentUser = user;
            notifyListeners();
          });
      notifyListeners();
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth().signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _syncUser(userCredential.user, provider: 'password');
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth().createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _syncUser(userCredential.user, provider: 'password');
  }

  Future<void> signInWithGoogle() async {
    if (!BackendConfig.hasGoogleClientId) {
      throw const BackendNotConfiguredException('Google Sign-In');
    }

    if (kIsWeb) {
      return;
    }

    await GoogleSignIn.instance.authenticate();
  }

  Future<void> signOut() async {
    if (firebaseEnabled && Firebase.apps.isNotEmpty) {
      await firebase_auth.FirebaseAuth.instance.signOut();
    }

    if (BackendConfig.hasGoogleClientId) {
      await GoogleSignIn.instance.signOut();
    }

    if (supabaseEnabled) {
      await Supabase.instance.client.auth.signOut();
    }
  }

  Future<void> _syncGoogleUser(GoogleSignInAccount user) async {
    final googleAuth = user.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth().signInWithCredential(
      credential,
    );
    await _syncUser(userCredential.user, provider: 'google');
  }

  Future<void> _syncUser(
    firebase_auth.User? user, {
    required String provider,
  }) async {
    if (user == null) {
      return;
    }

    await _syncFirestoreUser(user, provider: provider);
    await _syncSupabaseProfile(user, provider: provider);
  }

  Future<void> _syncFirestoreUser(
    firebase_auth.User user, {
    required String provider,
  }) async {
    if (!firebaseEnabled || Firebase.apps.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      'provider': provider,
      'lastLoginAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> _syncSupabaseProfile(
    firebase_auth.User user, {
    required String provider,
  }) async {
    if (!supabaseEnabled) {
      return;
    }

    await Supabase.instance.client.from('profiles').upsert({
      'id': user.uid,
      'email': user.email,
      'display_name': user.displayName,
      'avatar_url': user.photoURL,
      'provider': provider,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'id');
  }

  firebase_auth.FirebaseAuth _firebaseAuth() {
    if (!firebaseEnabled || Firebase.apps.isEmpty) {
      throw const BackendNotConfiguredException('Firebase');
    }

    return firebase_auth.FirebaseAuth.instance;
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _googleSubscription?.cancel();
    super.dispose();
  }
}

final authService = AuthService.instance;

class BackendNotConfiguredException implements Exception {
  const BackendNotConfiguredException(this.backendName);

  final String backendName;

  @override
  String toString() => '$backendName is not configured yet.';
}

class AuthCancelledException implements Exception {
  const AuthCancelledException();

  @override
  String toString() => 'Authentication flow was cancelled.';
}
