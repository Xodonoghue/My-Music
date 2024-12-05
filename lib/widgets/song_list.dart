import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/models/Song.dart';

class SongList extends StatefulWidget {
  List<String> selectedSongs = [];
  SongList({super.key});
  
  List<String> getSongs() {
    return selectedSongs;
  }

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  final Stream<QuerySnapshot> _songStream = FirebaseFirestore.instance.collection('songs').snapshots();
   
  List<bool> _selected = [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('songs').get().then((allDocs) => _selected = List<bool>.filled(allDocs.docs.length, false, growable: true));
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _songStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return Container(
          width: 200,
          height: 200,
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length, 
            itemBuilder: (context, index) => ListTile(
              tileColor: Colors.black,
              selected: _selected.length > 0?_selected[index]: false,
              selectedTileColor: Colors.blueAccent,
              leading: Image.network(snapshot.data!.docs[index]['imageUrl']), 
              title: Text(snapshot.data!.docs[index]['name'], 
              style: TextStyle(fontFamily: 'Cera Pro', 
              color: Colors.white, fontWeight: FontWeight.w700),), 
              subtitle: Text(snapshot.data!.docs[index]['artistName'], 
              style: TextStyle(fontSize: 14,fontFamily: 'Cera Pro', 
              color: Colors.white, fontWeight: FontWeight.w300)),
              onTap: () => {_selected[index] = !_selected[index], 
              if (widget.selectedSongs.contains(snapshot.data!.docs[index]['songId'])){ 
                widget.selectedSongs.remove(snapshot.data!.docs[index]['songId'])
                } else {widget.selectedSongs.add(snapshot.data!.docs[index]['songId'])
                },
              setState(() {}), },
              )
          ),
        );
      },
    );
  }
}