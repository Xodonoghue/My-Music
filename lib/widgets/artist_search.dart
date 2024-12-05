import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/controllers/artist_controller.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/views/upload_song_screen.dart';

class ArtistSearch extends StatefulWidget {
  final TextEditingController artistNameController;
  UploadSongScreen ups;
  ArtistSearch({required this.artistNameController, required this.ups, super.key});

  @override
  State<ArtistSearch> createState() => _ArtistSearchState();
}

class _ArtistSearchState extends State<ArtistSearch> {
  ArtistController ac = ArtistController();
  List<bool> _selectedList = [];
  Artist? artist;

  @override
  Widget build(BuildContext context) {
    if (_selectedList.isEmpty) {
       ac.artistsLen().then((len) => _selectedList = List<bool>.filled(len, false, growable: true));
    }
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('artists').where('name', isGreaterThanOrEqualTo: widget.artistNameController.text.trim()).snapshots(), builder: ((context, snapshot) {
      if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return Container(width: MediaQuery.of(context).size.width - 100, height: 200, child: ListView.builder(itemCount: snapshot.data!.docs.length ,itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(onTap: () {
                      if (_selectedList[index] == false) {
                      for (int i = 0; i < _selectedList.length; i++) {
                        _selectedList[i] = false;
                      }
                        _selectedList[index] = true;
                        artist = Artist.fromSnap(snapshot.data!.docs[index]);
                      } else {
                        _selectedList[index] = false;
                        artist = null;
                      }
                      setState(() {});
                      widget.ups.setArtist(artist);
                      
                    },selected: _selectedList.isEmpty? false: _selectedList[index], selectedTileColor: Colors.blue,leading: ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.network(snapshot.data!.docs[index]["imageUrl"])), title: Text(snapshot.data!.docs[index]["name"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),)
                    ),
          );
        })),);
    }));
  }
}