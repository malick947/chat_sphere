
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class Facebook_auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.tokenString);

        UserCredential userCredential =
        await _auth.signInWithCredential(facebookAuthCredential);

        return userCredential.user;
      } else {
        Get.snackbar('Login Failed', result.message ?? 'Unknown error');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to authenticate with Facebook');
      return null;
    }
  }
}
