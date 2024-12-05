import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mymusic/models/Album.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/models/Song.dart';

class ArtistController extends ChangeNotifier {
  Stream<QuerySnapshot> searchArtists(String song) {
    return FirebaseFirestore.instance.collection('artists').where('name', isGreaterThanOrEqualTo: song).snapshots();
  }

  Future<String> uploadImage(String id, String folder, File image) async {
    final Reference ref = FirebaseStorage.instance.ref().child(folder).child(id);
    TaskSnapshot snap = await ref.putFile(image);
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadArtist(File image, String name, String description) async{
    
    //try {
      var allDocs = await FirebaseFirestore.instance.collection('artists').get();
      print("img-${allDocs.docs.length}");
      String imageUrl = await uploadImage("img-${allDocs.docs.length}", "profile-pics", image);
      Artist artist = Artist(imageUrl: imageUrl, name: name, description: description);
      FirebaseFirestore.instance.collection("artists").add(artist.toJson()).then((docRef) => docRef.update({"artistId": docRef.id}));
    //} catch(e) {
      //print(e);
    //}
  }

  addSongs(Artist artist, List<Song> songs){
    List<dynamic>? artistSongs = [];
    if (artist.songs != null) {
      artistSongs = artist.songs;
    }
    for (Song song in songs) {
      artistSongs!.add(song);
    }
    FirebaseFirestore.instance.collection("artists").doc(artist.artistId).update({"songs": artistSongs});
  }

  addAlbums(Artist artist, List<Album> albums){
    List<dynamic>? artistAlbums = [];
    if (artist.songs != null) {
      artistAlbums = artist.songs;
    }
    for (Album album in albums) {
      artistAlbums!.add(album);
    }
    FirebaseFirestore.instance.collection("artists").doc(artist.artistId).update({"albums": artistAlbums});
  }

  artistsLen() async{
    QuerySnapshot ref = await FirebaseFirestore.instance.collection("artists").get();
    return ref.docs.length;
  }
  
}