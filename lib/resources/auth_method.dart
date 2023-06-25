import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  Future<String> signUp({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async {
    String res = " some error occured";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Uploading profile Image to firestorage ------
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePic', file, false);

        // uploading user data to firestore
        _firebaseStorage.collection('users').doc(cred.user!.uid).set({
          'username': userName,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'following': [],
          'follower': [],
          'photoUrl': photoUrl,
        });
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      res = e.toString();
      print(e.toString());
    }
    return res;
  }
}
