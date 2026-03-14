import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/core/errors/exception.dart';

class FirebaseAuthService {
  Future deleteCurrentUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

 String getUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code: ${e.code}',
      );
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          message: 'The account already exists for that email.',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          message: 'Network error. Please check your internet connection.',
        );
      } else {
        throw CustomException(message: 'An unknown error occurred.');
      }
    } catch (e) {
      throw CustomException(message: 'An unknown error occurred.');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code: ${e.code}',
      );
      if (e.code == 'user-not-found') {
        throw CustomException(
          message: 'Wrong password or email provided for that user.',
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(
          message: 'Wrong password or email provided for that user.',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          message: 'Network error. Please check your internet connection.',
        );
      } else {
        throw CustomException(message: 'An unknown error occurred.');
      }
    } catch (e) {
      throw CustomException(message: 'An unknown error occurred.');
    }
  }

  // Future<User> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  // }

  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }



  Future<void> sendPasswordResetEmail({required String email}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    log(
      'exception in FirebaseAuthService.sendPasswordResetEmail: ${e.toString()} and code: ${e.code}',
    );

    if (e.code == 'user-not-found') {
      throw CustomException(message: 'No user found for that email.');
    } else if (e.code == 'invalid-email') {
      throw CustomException(message: 'The email address is invalid.');
    } else if (e.code == 'network-request-failed') {
      throw CustomException(
        message: 'Network error. Please check your internet connection.',
      );
    } else {
      throw CustomException(message: 'An unknown error occurred.');
    }
  } catch (e) {
    throw CustomException(message: 'An unknown error occurred.');
  }
}


Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    log('exception in FirebaseAuthService.signOut: ${e.toString()}');
    throw CustomException(message: 'Error occurred while signing out.');
  }
}
}
