import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/models/Album.dart';

class UploadAlbumController extends ChangeNotifier {
  @override
  notifyListeners() {

  }
  uploadImage(String id, File image) async {
    final Reference ref = FirebaseStorage.instance.ref().child('album-coverArt').child(id);
    TaskSnapshot snap = await ref.putFile(image);
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  createAlbum(String imageUrl, String name, String artistName, String? artistId,List<Song> songs) async{
    try{
    List<dynamic> songList = [];
    for (Song s in songs) {
      songList.add(s.name);
    }
    Album album = Album(imageUrl: imageUrl, name: name, artistName: artistName, artistId: artistId, songs: songList);

    final CollectionReference ref = FirebaseFirestore.instance.collection('albums');
    await ref.add(album.toJson()).then((docRef) => {
    docRef.update({'albumId': docRef.id})});
    } catch(e) {
      print(e);
    }
  }

}