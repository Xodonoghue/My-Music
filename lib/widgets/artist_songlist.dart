import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/widgets/song_tile.dart';

class ArtistSonglist extends StatefulWidget {
  Artist artist;
  ArtistSonglist({
    required this.artist,
    super.key});

  @override
  State<ArtistSonglist> createState() => _ArtistSonglistState();
}

class _ArtistSonglistState extends State<ArtistSonglist> {
  late Future<List<Song>> _data;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _data = widget.artist.getSongs();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _data, builder: ((context, snapshot){
      if (snapshot.hasError){
        return const Text('Something went wrong');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text("Loading");
      }
      return Container(width: MediaQuery.of(context).size.width - 250, height: 200, child: ListView.separated(itemBuilder: (context, index) {
        return SongTile(imageUrl: snapshot.data![index].imageUrl, 
                    name: snapshot.data![index].name, artistName: snapshot.data![index].artistName, album: 'Too Hard', );
      }, separatorBuilder: (context, index) => 
          Divider(color: Colors.white, thickness: 1,), 
          itemCount: snapshot.data!.length),);
    }));
  }
}