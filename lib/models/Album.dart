import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Song.dart';

class Album {
  String imageUrl;
  String artistName;
  String? artistId;
  String name;
  List<dynamic> songs;
  Album({
    required this.imageUrl, 
    required this.artistName,
    required this.artistId, 
    required this.name, 
    required this.songs});
    static Album fromSnap(DocumentSnapshot snapshot) {
      var snap = snapshot.data() as Map<String, dynamic>;
      Album album =  Album(
      imageUrl: snap['imageUrl'], 
      artistName: snap['artistName'],
      artistId: snap['artistId'], 
      name: snap['name'],
      songs: snap['songs'],);
    return album;
    }

    Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "name": name,
    "artistName": artistName,
    "artistId": artistId,
    "songs" : songs
  };
  
  Future<List<Song>> findSongs() async{
    List<Song> songs = [];
    for (dynamic song in songs) {
      songs.add(Song.fromSnap(await FirebaseFirestore.instance.collection('songs').doc(song).get()));
    }
    return songs;
  }
}
