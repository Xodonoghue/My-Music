import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {


Future<String> getName() async {
  final CollectionReference trendingSongs = FirebaseFirestore.instance.collection('Trending-Songs');
  DocumentSnapshot songs = await trendingSongs.doc("Let-Ha-Go").get();
  return (songs.data()! as dynamic)['name'];
}
}