import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/constants.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/views/song_screen.dart';

import '../views/profile_screen.dart';

class SongView extends StatelessWidget {
  final Song song;
  final double height;
  final double width;
  SongView({
    super.key, 
    required this.song,
    required this.height,
    required this.width,
    });
  Artist? artist;
  

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('artists').doc(song.artistId).get().then((snap) => artist = Artist.fromSnap(snap));
    return InkWell(
      onTap: () => {
        baseScreen.paused = false,
        baseScreen.songWatch.value = song,
        baseScreen.setSong(song),
        baseScreen.play(),
        Navigator.push(context, MaterialPageRoute(builder: (context) => SongScreen(song: song, audioPlayer: baseScreen.audioPlayer)))
        
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
              padding: EdgeInsets.all(6),
              height: height,
              width: width,
              child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: Image.network(song.imageUrl,)),
            ),
            Text(song.name, style: TextStyle(fontFamily: 'Cera Pro',
                color: Colors.white, fontWeight: FontWeight.w700),),
            SizedBox(height: 4,),
            InkWell(
              onTap: () async{
                if (artist != null) {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => ProfileScreen(artist: artist!,)));
                }
                 
              },
              child: Text(song.artistName, style: TextStyle(fontFamily: 'Cera Pro',
                  color: Colors.white, fontWeight: FontWeight.w200),),
            ),
            ]
          ),
        ),
      ),
    );
  }
}