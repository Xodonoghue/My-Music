import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/widgets/song_view.dart';

class HomeController extends StatefulWidget {
   HomeController({super.key});
   static late Song song;
    Future<Song> getSong() async {
    DocumentSnapshot songSnap = await FirebaseFirestore.instance.collection('songs').doc("Song-0").get();
    song = Song.fromSnap(songSnap);
    return Song.fromSnap(songSnap);
  }

  @override
  State<HomeController> createState() => _HomeControllerState();
  
}

class _HomeControllerState extends State<HomeController> {
  final Stream<QuerySnapshot> _songStream =
      FirebaseFirestore.instance.collection('songs').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _songStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => snapshot.data!.docs.length <= 0 ? Text("Error Music Unavailable"):
              SongView(song: Song.fromSnap(snapshot.data!.docs[index]), height: 160, width: 160),
            scrollDirection: Axis.horizontal,
          );
      },
    );
  }
}
