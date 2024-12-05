import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Album.dart';
import 'package:mymusic/widgets/album_view.dart';

class HomeAlbums extends StatefulWidget {
  HomeAlbums({super.key});

  @override
  State<HomeAlbums> createState() => _HomeAlbumsState();
}

class _HomeAlbumsState extends State<HomeAlbums> {
  Stream<QuerySnapshot> _albumStream = FirebaseFirestore.instance.collection('albums').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _albumStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) =>  AlbumView(album: Album.fromSnap(snapshot.data!.docs[index]), height:160, width: 160)
        );
      });
  }
}