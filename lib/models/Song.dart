import 'package:cloud_firestore/cloud_firestore.dart';

class Song{
  String imageUrl;
  String songUrl;
  String name;
  String artistName;
  String? artistId;
  String? songId;

  Song({
    required this.imageUrl,
    required this.songUrl,
    required this.name,
    required this.artistName,
    required this.artistId,
    this.songId,
  });

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "songUrl": songUrl,
    "name": name,
    "artistName": artistName,
    "artistId": artistId,
    "songId": songId
  };

  static Song fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    Song song =  Song(
      imageUrl: snap['imageUrl'],
      songUrl: snap['songUrl'], 
      artistName: snap['artistName'], 
      artistId: snap['artistId'],
      name: snap['name'],
      songId: snap["songId"]);
    return song;
  }
  

}