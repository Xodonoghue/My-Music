import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/constants.dart';
import 'package:mymusic/models/User.dart' as model;

class LibController extends ChangeNotifier {
  Future<List<dynamic>> getSongRefs() async {
    model.User? user = await authController.user();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    List<dynamic> songList = [];
    if (doc['songs'] != null) {
      songList = doc['songs'];
    }
    return songList;
  }

  Future<List<dynamic>> getAlbumRefs() async {
    model.User? user = await authController.user();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    List<dynamic> albumList = [];
    if (doc['albums'] != null) {
      albumList = doc['albums'];
    }
    return albumList;
  }

  Future<List<Song>> getSongs() async {
    print(authController.user);
    List<Song> songs = [];
    List<dynamic> songIds = [];
    List<dynamic> songList = await getSongRefs();
    for (String song in songList) {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('songs').doc(song).get();
      if (!songIds.contains(snap['songId'])) {
        songs.add(Song.fromSnap(snap));
        songIds.add(snap['songId']);
      }
    }
    return songs;
  }

  Future<List<Song>> getAlbums() async {
    List<Song> albums = [];
    List<dynamic> albumIds = [];
    List<dynamic> albumList = await getAlbumRefs();
    for (String album in albumList) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('albums')
          .doc(album)
          .get();
      if (!albumIds.contains(snap['albumId'])) {
        albums.add(Song.fromSnap(snap));
        albumIds.add(snap['albumId']);
      }
    }
    return albums;
  }

  addSongToLib(Song song) async {
    model.User? user = await authController.user();
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    List<dynamic> songs = [];
    if (snap["songs"] != null) {
      songs = snap["songs"];
    }
    songs.add(song.songId!);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({"songs": songs});
  }
}
