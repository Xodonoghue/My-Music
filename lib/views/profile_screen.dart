import 'package:flutter/material.dart';
import 'package:mymusic/controllers/profile_screen_controller.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/widgets/artist_albums_view.dart';
import 'package:mymusic/widgets/artist_songlist.dart';
import 'package:mymusic/widgets/profile_album_tile.dart';
import 'package:mymusic/widgets/song_tile.dart';

class ProfileScreen extends StatelessWidget {
  final Artist artist;
  const ProfileScreen({
    required this.artist,
    super.key,});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(child: ListView(children: [
        Center(
          child: Text(artist.name, style: TextStyle(fontFamily: 'Cera Pro',
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),),
        ),
        SizedBox(height: 15,),
        Center(
          child: Container(
            height: 130,
            width: 130,
            child: ClipRRect(borderRadius: BorderRadius.circular(200), child: Image.network(artist.imageUrl),),),
        ),
        SizedBox(height: 15,),
        Container(
          margin: EdgeInsets.only(bottom: 10, left: 40, right: 40),
          child: Text(artist.description, style: TextStyle(fontFamily: 'Cera Pro',
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15,),
                textAlign: TextAlign.center,),
        ),
        Padding(padding: EdgeInsets.all(5), child: Text("Top Songs", style: TextStyle(fontFamily: 'cera pro', color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),)),
        ArtistSonglist(artist: artist),
        SizedBox(height: 15,),
        Text("Albums", style: TextStyle(fontFamily: 'cera pro', color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),),
        ArtistAlbumsView(artist: artist),
          ],
        ),
      ),
    );
  }
}