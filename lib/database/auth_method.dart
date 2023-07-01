import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/model/user.dart' as model;
import 'package:instagram_clone/database/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // get the existing user details

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firebaseFirestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

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
        UserCredential _cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(_cred.user!.uid);

        // Uploading profile Image to firestorage ------
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePic', file, false);

        // uploading user data to firestore

        model.User user = model.User(
          username: userName,
          uid: _cred.user!.uid,
          email: email,
          bio: bio,
          following: [],
          followers: [],
          photoUrl: photoUrl,
        );

        _firebaseFirestore
            .collection('users')
            .doc(_cred.user!.uid)
            .set(user.toJson());
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'unknown') return res = 'Please enter all the fields';

      res = e.message.toString();
      print(e.toString());
    }
    return res;
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = 'Please enter all the fields';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';

        print(_auth.currentUser!.uid);
      }
    } on FirebaseAuthException catch (e) {
      res = e.message.toString();
      print(e.message.toString());
    }

    return res;
  }
}
