import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchController extends ChangeNotifier{
   Stream<QuerySnapshot> searchUsers(String song) {
    return FirebaseFirestore.instance.collection('songs').where('name', isGreaterThanOrEqualTo: song).snapshots();
  }
  
}