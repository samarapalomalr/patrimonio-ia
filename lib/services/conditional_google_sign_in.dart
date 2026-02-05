// Apenas Mobile (Android/iOS)
import 'package:google_sign_in/google_sign_in.dart';

Future<GoogleSignInAccount?> signInWithGoogle() async {
  return await GoogleSignIn().signIn();
}
