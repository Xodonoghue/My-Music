import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Album.dart';
import 'package:mymusic/models/Song.dart';

class Artist {
  String imageUrl;
  String name;
  String? artistId;
  String description;
  List<dynamic>? songs = [];
  List<dynamic>? albums = [];
  Artist({required this.imageUrl,required this.name, required this.description, this.songs, this.albums, this.artistId});

  static Artist fromSnap(DocumentSnapshot snap){
    Artist artist = Artist(imageUrl: snap["imageUrl"],name: snap["name"], songs: snap["songs"], description: snap["description"], albums: snap["albums"], artistId: snap["artistId"]);
    return artist;
  }
  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "name": name,
    "songs": songs,
    "albums": albums,
    "artistId": artistId,
    "description": description
  };

  Future<List<dynamic>> getSongList() async{
    List<dynamic> songs = [];
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('artist').doc(artistId).get();
    songs = snap["songs"];
    return songs;
  }

  Future<List<Song>> getSongs() async {
    List<Song> songsOut = [];
    for (dynamic s in songs!) {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('songs').doc(s).get();
      Song song = Song.fromSnap(snap);
      songsOut.add(song);
    }
    return songsOut;
  }

  Future<List<Album>> getAlbums() async {
    List<Album> albumsOut = [];
    for (dynamic a in albums!) {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('albums').doc(a).get();
      Album album = Album.fromSnap(snap);
      albumsOut.add(album);
    }
    return albumsOut;
  }


}