import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/models/User.dart';
import 'package:mymusic/constants.dart';

class SongLibController extends ChangeNotifier {
  Future<List<dynamic>> getSongRefs() async {
    User? user = await authController.user();
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    print(doc);
    List<dynamic> songList = [];
    if (doc['songs'] != null) {
      songList = doc['songs'];
    }
    ;
    print(songList);
    return songList;
  }

  Future<List<Song>> getSongs() async {
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

  addSongToLib(Song song) async {
    User? user = await authController.user();
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
        .doc(user.uid)
        .update({"songs": songs});
  }
}
