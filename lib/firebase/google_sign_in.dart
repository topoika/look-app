import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look/constant/variables.dart';
import 'package:look/firebase/termscondition.dart';
import 'package:look/profile/education.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  final GoogleSignIn googleSignIn = GoogleSignIn();
   Future<User?> signInWithGoogle({required BuildContext context}) async {


    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        EMAIL=user!.email as String;
        NAME=user!.displayName as String;
        Get.to(()=>const TermsAndCondition(val:true));

      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'account-exists-with-different-credential') {

          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }
   Future<void> signOutFromGoogle() async{
     await googleSignIn.signOut();
     await auth.signOut();
   }
}