import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymusic/controllers/album_screen_controller.dart';
import 'package:mymusic/models/Album.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/views/album_screen.dart';
import 'package:mymusic/views/profile_screen.dart';

class AlbumView extends StatelessWidget {
  final Album album;
  final double height;
  final double width;
  AlbumView({
    required this.album,
    required this.height,
    required this.width,
    super.key});
  Artist? artist;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('artists').doc(album.artistId).get().then((snap) => artist = Artist.fromSnap(snap));
    return InkWell(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumScreen(album: album)))},
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
                child: Image.network(album.imageUrl,)),
              ),
              Text(album.name, style: TextStyle(fontFamily: 'Cera Pro',
                  color: Colors.white, fontWeight: FontWeight.w700),),
              SizedBox(height: 4,),
              InkWell(
                onTap: () async{
                if (artist != null) {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => ProfileScreen(artist: artist!,)));
                }
                 
              },
                child: Text(album.artistName, style: TextStyle(fontFamily: 'Cera Pro',
                    color: Colors.white, fontWeight: FontWeight.w200),),
              ),
              ]
            ),
          ),
        ),
    );
  }
}