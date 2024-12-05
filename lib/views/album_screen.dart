import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mymusic/constants.dart';
import 'package:mymusic/controllers/album_screen_controller.dart';
import 'package:mymusic/controllers/lib_controller.dart';
import 'package:mymusic/models/Album.dart';
import 'package:mymusic/models/Artist.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/models/User.dart';
import 'package:mymusic/views/profile_screen.dart';
import 'package:mymusic/views/signup_screen.dart';

class AlbumScreen extends StatefulWidget {
  final Album album;
  AlbumScreen({required this.album, super.key});
  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  AlbumScreenController ac = AlbumScreenController();
  late LibController slc = LibController();
  bool found = false;
  List<Song> songs = [];
  List<bool> _selectedList = [];
  late Artist artist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ac.findSongs(widget.album).then((value) => {
          songs = ac.getSongs(),
          _selectedList =
              List<bool>.filled(ac.getSongs().length, false, growable: true),
          setState(() {})
        });
    ac.getArtist(widget.album.artistId!).then((value) => artist = value);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: Image.network(widget.album.imageUrl)),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 4),
              alignment: Alignment.center,
              child: Text(
                widget.album.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4, left: 20, right: 20, bottom: 20),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                artist: artist,
                              )));
                },
                child: Text(
                  widget.album.artistName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Container(
                height: 400,
                width: 200,
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                    itemCount: songs.length,
                    itemBuilder: ((context, index) => ListTile(
                        title: Text(
                          songs[index].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        leading: InkWell(
                          onTap: () => slc.addSongToLib(songs[index]),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        trailing: _selectedList[index]
                            ? Icon(
                                Icons.pause,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                        onTap: () => {
                              if (_selectedList[index] == false)
                                {
                                  if (baseScreen.getSong() == songs[index])
                                    {baseScreen.playpause()}
                                  else
                                    {
                                      baseScreen.paused = false,
                                      baseScreen.songWatch.value = songs[index],
                                      baseScreen.setSong(songs[index]),
                                      baseScreen.play(),
                                    },
                                  for (int i = 0; i < _selectedList.length; i++)
                                    {
                                      if (_selectedList[i] == true)
                                        {_selectedList[i] = false}
                                    },
                                  _selectedList[index] = true
                                }
                              else
                                {
                                  baseScreen.playpause(),
                                  _selectedList[index] = false
                                },
                              setState(() {}),
                            })))),
            Row(
              children: [
                Text("Don't have an account"),
                InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen())),
                    child: Text("Sign Up Here"))
              ],
            )
          ],
        ));
  }
}
