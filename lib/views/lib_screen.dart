import 'package:flutter/material.dart';
import 'package:mymusic/controllers/home_controller.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/views/profile_screen.dart';
import 'package:mymusic/views/song_lib_screen.dart';
import 'package:mymusic/views/upload_artist_screen.dart';
import 'package:mymusic/widgets/message_view.dart';
import 'package:mymusic/widgets/song_view.dart';

class LibScreen extends StatefulWidget {
  
  LibScreen({super.key});
  late Song song;
  
  HomeController homeController = HomeController();
  
  @override
  State<LibScreen> createState() => _LibScrenState();
}

class _LibScrenState extends State<LibScreen> {
  
  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    return Scaffold(
      backgroundColor: Colors.black12,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Text("Library", style: TextStyle(fontFamily: 'Cera Pro',
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),
                ),
          ),
          SizedBox(height: 4,),
          ListTile(
            leading: Icon(Icons.music_note, color: Colors.white,),
            title: Text("Songs", style: TextStyle(fontFamily: 'Cera Pro',
              color: Colors.white, fontWeight: FontWeight.w700),),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SongLibScreen(),)),
            
          ),
          ListTile(
            leading: Icon(Icons.album, color: Colors.white),
            title: Text("Albums", style: TextStyle(fontFamily: 'Cera Pro',
              color: Colors.white, fontWeight: FontWeight.w700),),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text("Artists", style: TextStyle(fontFamily: 'Cera Pro',
              color: Colors.white, fontWeight: FontWeight.w700),),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadArtistScreen(),)),
          ),
          Container(
            height: 600,
            child: FutureBuilder<Song>(
                  future: homeController.getSong(),
                  builder: (context, song)  {
                    if (song.hasError) {
                      return Text("Songs unable to load.");
                    } else if (song.hasData) {
                      return GridView.count(
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        crossAxisCount: 2,
                        children: [
                          SongView(song: song.data!, height: 160, width: 160,),
                          SongView(song: song.data!, height: 160, width: 160,),
                          SongView(song: song.data!, height: 160, width: 160,),
                          SongView(song: song.data!, height: 160, width: 160,),
                          SongView(song: song.data!, height: 160, width: 160,),
                          SongView(song: song.data!, height: 160, width: 160,),
                          SongView(song: song.data!, height: 160, width: 160,),
                            ],
                      );
                    } else {
                      return Text("Songs loading...");
                    }
                  },
                ),
          ),
          ElevatedButton(style: ButtonStyle(),onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MessageView(message: "Just Vibe")));
          }, child: Text("Button"))
        ],
      ),
    );
  }
}