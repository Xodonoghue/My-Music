import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String uid;
  String email;
  List<dynamic>? songs = [];
  List<dynamic>? albums = [];
  User({required this.username, required this.uid, required this.email, this.songs, this.albums});

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "songs": songs,
    "albums": albums,
  };

  static User fromSnap(DocumentSnapshot snap) {
    User user = User(
      username: snap['username'], 
      uid: snap['uid'],
      email: snap['email'],
      songs: snap['songs'],
      albums: snap['albums']
    );
    return user;
  }
}