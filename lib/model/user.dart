import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final List following;
  final List followers;
  final String photoUrl;

  const User({
    required this.username,
    required this.uid,
    required this.email,
    required this.bio,
    required this.following,
    required this.followers,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'following': following,
        'followers': followers,
        'photoUrl': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      following: snapshot['following'],
      followers: snapshot['followers'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
