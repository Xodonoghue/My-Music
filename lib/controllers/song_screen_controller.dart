import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Artist.dart';

class SongScreenController extends ChangeNotifier {
  getArtist(String id) async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('artists').doc(id).get();
    return Artist.fromSnap(snap);
  }
}