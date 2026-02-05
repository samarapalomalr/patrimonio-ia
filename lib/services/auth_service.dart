import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Só importa GoogleSignIn se não for Linux/Mac/Windows Desktop
/// e não for Web, apenas Mobile (Android/iOS)
import 'conditional_google_sign_in.dart'
    if (dart.library.io) 'conditional_google_sign_in_stub.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================= GOOGLE LOGIN =================
  Future<UserCredential?> loginGoogle() async {
    try {
      if (kIsWeb) {
        // Login Web
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        return await _auth.signInWithPopup(googleProvider);
      }
      // Mobile (Android/iOS)
      else if (!kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS)) {
        final googleUser =
            await signInWithGoogle(); // vem do conditional_google_sign_in.dart
        if (googleUser == null) return null;

        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
      // Desktop (Linux/Mac/Windows)
      else {
        debugPrint('Login com Google não suportado nesta plataforma');
        return null;
      }
    } catch (e) {
      debugPrint('Erro login Google: $e');
      return null;
    }
  }

  // ================= EMAIL/SENHA =================
  Future<UserCredential?> loginEmail(String email, String senha) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  Future<User?> registerEmail({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );

    await cred.user!.updateDisplayName(nome);
    await cred.user!.reload();

    return _auth.currentUser;
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ================= CURRENT USER =================
  User? get currentUser => _auth.currentUser;
}
