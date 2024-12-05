import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Album.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/models/Song.dart';

class AlbumScreenController extends ChangeNotifier {
  List<Song> songs = [];
  List<String> songIds = [];
  List<Song> getSongs() {
    return songs;
  }
  getArtist(String id) async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('artists').doc(id).get();
    return Artist.fromSnap(snap);
  }

  findSongIds(Album album) async{
    for (String song in album.songs) {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('songs').doc(song).get();
        if (!songIds.contains(snap['songId'])) {
          songs.add(Song.fromSnap(snap));
          songIds.add(snap['songId']);
        } 
      } 
    }

  findSongs(Album album) async{ 
    for (String song in album.songs) {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('songs').doc(song).get();
        if (!songIds.contains(snap['songId'])) {
          songs.add(Song.fromSnap(snap));
          songIds.add(snap['songId']);
        } 
      }
  }
  
}
