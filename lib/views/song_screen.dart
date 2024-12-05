import 'package:flutter/material.dart';
import 'package:mymusic/controllers/lib_controller.dart';
import 'package:mymusic/controllers/song_screen_controller.dart';
import 'package:mymusic/models/Song.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mymusic/views/profile_screen.dart';
import 'package:mymusic/widgets/seekbar.dart';
import 'package:mymusic/widgets/widgets.dart';
import 'package:rxdart/rxdart.dart';

import '../models/Artist.dart';


class SongScreen extends StatefulWidget {
  final Song song;
  final AudioPlayer audioPlayer;
  SongScreen({
    required this.song,
    required this.audioPlayer,
    super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
  
}

class _SongScreenState extends State<SongScreen> {
    LibController controller = LibController();
    late Artist artist;
    SongScreenController songScreenController = SongScreenController();
    Stream<SeekBarData> get _seekBarDataStream => Rx.combineLatest2<Duration, Duration?, SeekBarData>(
      widget.audioPlayer.positionStream, 
      widget.audioPlayer.durationStream,
      (Duration position, Duration? duration) {
        return SeekBarData(position, duration ?? Duration.zero);
      });
  @override void initState() {
    // TODO: implement initState
    super.initState();
    songScreenController.getArtist(widget.song.artistId!).then((value) => artist = value);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromARGB(255, 23, 23, 23), Color.fromARGB(255, 71, 71, 71)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(child: Image.network(widget.song.imageUrl, width: MediaQuery.of(context).size.width - 150,), borderRadius: BorderRadius.circular(25),),
            SizedBox(height: 15),
            ListTile(
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Text(widget.song.name, style: TextStyle(fontSize: 18, fontFamily: 'Cera Pro', fontWeight: FontWeight.w700, color: Colors.white),), 
              subtitle: Text(widget.song.artistName, style: TextStyle(fontSize: 16, fontFamily: 'Cera Pro', fontWeight: FontWeight.w300, color: Colors.white),),
              trailing: PopupMenuButton(color: Colors.white,itemBuilder: (context) => [
                PopupMenuItem(child: Text("Add to Library"),  onTap: () => controller.addSongToLib(widget.song),)
              ],)
            ),
              Padding(
                padding: EdgeInsets.only(right: 25, left: 25, top: 5, bottom: 10),
                child: Column(
                  children: [StreamBuilder(stream: _seekBarDataStream ,builder: (context, snapshot){
                    final positionData = snapshot.data;
                    return SeekBar(
                      position: positionData?.position ?? Duration.zero, 
                      duration: positionData?.duration ?? Duration.zero,
                      onChangeEnd: widget.audioPlayer.seek,);
                  }),]
                ),
              ),
            SizedBox(height: 15),
            PlayerButtons(audioPlayer: widget.audioPlayer),
          ],
          ),
      ),
      );
  }
}