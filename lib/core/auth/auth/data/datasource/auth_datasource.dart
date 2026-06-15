import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discrete_math/secret_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDatasource {
  Future<bool> googleSignIn();
}

class GoogleDataSource implements AuthDatasource {
  @override
  Future<bool> googleSignIn() async {
    print("🚀 AuthStart triggered");

    try {
      print("🔹 Initializing GoogleSignIn with serverClientId...");
      await GoogleSignIn.instance.initialize(serverClientId: GOOGLE);
      print("✅ GoogleSignIn initialized");

      GoogleSignInAccount? googleUser;
      try {
        print("🔹 Starting Google authentication...");
        googleUser = await GoogleSignIn.instance.authenticate();
        print("✅ Google authentication finished");
      } catch (authError) {
        print("❌ Error during GoogleSignIn.authenticate(): $authError");
        rethrow;
      }

      // if (googleUser == null) {
      //   print(
      //     "ℹ️ Користувач скасував вхід через Google (googleUser == null)",
      //   );
      //   return;
      // }

      GoogleSignInAuthentication googleAuth;
      try {
        print("🔹 Getting GoogleSignInAuthentication...");
        googleAuth = await googleUser.authentication;
        print(
          "✅ GoogleSignInAuthentication obtained: idToken length = ${googleAuth.idToken?.length}",
        );
      } catch (authTokenError) {
        print("❌ Error obtaining GoogleSignInAuthentication: $authTokenError");
        rethrow;
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      print("🔹 Firebase credential created");

      UserCredential userCredential;
      try {
        print("🔹 Signing in with Firebase...");
        userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
        print(
          "✅ Firebase sign-in successful, user uid = ${userCredential.user?.uid}",
        );
      } catch (firebaseError) {
        print("❌ Firebase sign-in error: $firebaseError");
        rethrow;
      }

      final user = userCredential.user;
      if (user != null) {
        try {
          print("🔹 Fetching user document from Firestore...");
          final userDoc = await FirebaseFirestore.instance
              .collection('accounts')
              .doc(user.uid)
              .get();

          if (!userDoc.exists) {
            print("ℹ️ User document does not exist, may need to create");
          } else {
            print("✅ User document exists");
          }
        } catch (firestoreError) {
          print("❌ Error fetching user document: $firestoreError");
        }
      }
      return true;
    } catch (e) {
      print("❌ Google sign-in error caught in outer try: $e");
      return false;
    }
  }
}
