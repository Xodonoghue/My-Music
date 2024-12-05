import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Album.dart';
import 'package:mymusic/models/Song.dart';

class UploadSongController extends ChangeNotifier {
  
  uploadImage(String id, String folder, File image) async {
    final Reference ref = FirebaseStorage.instance.ref().child(folder).child(id);
    TaskSnapshot snap = await ref.putFile(image);
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadSongFile(String id, File song) async {
    final Reference ref = FirebaseStorage.instance.ref().child('songs').child(id);
    TaskSnapshot snap = await ref.putFile(song);
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  UploadSong(String name, String artistName, File songFile, File image, String? artistId) async{
    try{
    var allDocs = await FirebaseFirestore.instance.collection('songs').get();
    int len = allDocs.docs.length;
    String imageUrl = await uploadImage("Img-$len", "songImages", image);
    String songUrl = await uploadSongFile("Song-$len", songFile);
    Song song = Song(imageUrl: imageUrl, songUrl: songUrl, name: name, artistName: artistName, artistId: artistId);
    final CollectionReference ref = FirebaseFirestore.instance.collection('songs');
    DocumentReference artistRef = FirebaseFirestore.instance.collection('artists').doc(artistId);
    DocumentSnapshot snap = await artistRef.get();
    List<dynamic> songlist = [];
    await ref.add(song.toJson()).then((docRef) async => {
    docRef.update({'songId': docRef.id}),
    if(snap["songs"] == null) {
      artistRef.update({"songs": [docRef.id]})
    } else {
      songlist = snap["songs"],
      songlist.add(docRef.id),
      artistRef.update({"songs": songlist})
    }
    });
    } catch(e) {
      print(e);
    }
  }

   createAlbum(String name, String artistName, String? artistId, List<String> songs, File image) async{
      try{
        var allDocs = await FirebaseFirestore.instance.collection('albums').get();
        int len = allDocs.docs.length;
        String imageUrl = await uploadImage("Img-$len", "albumImages", image);
        Album album = Album(imageUrl: imageUrl, name: name, artistName: artistName, artistId: artistId, songs: songs);
        final CollectionReference ref = FirebaseFirestore.instance.collection('albums');
        DocumentReference artistRef = FirebaseFirestore.instance.collection('artists').doc(artistId);
        DocumentSnapshot snap = await artistRef.get();
        List<dynamic> albumlist = [];
        await ref.add(album.toJson()).then((docRef) => {
        docRef.update({'albumId': docRef.id}),
        if(snap["albums"] == null) {
          artistRef.update({"albums": [docRef.id]})
        } else {
          albumlist = snap["albums"],
          albumlist.add(docRef.id),
          artistRef.update({"albums": albumlist})
        }
        });
      } catch(e) {
        print(e);
      }
  }
}