import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mymusic/constants.dart';
import 'package:mymusic/models/Song.dart';
import 'package:mymusic/views/song_screen.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({super.key});
  Song? song;
  setSong(Song song) {
    this.song = song;
  }

  Song? getSong() {
    return this.song;
  }

  late ValueNotifier<Song?> songWatch = ValueNotifier(song);
  bool isPlaying = false;
  bool paused = false;
  AudioPlayer audioPlayer = AudioPlayer();
  play() {
    audioPlayer.setAudioSource(ConcatenatingAudioSource(
        children: [AudioSource.uri(Uri.parse(song!.songUrl))]));
    audioPlayer.play();
    isPlaying = true;
  }

  playpause() {
    if (!isPlaying) {
      if (paused) {
        audioPlayer.play();
        isPlaying = true;
        paused = false;
      } else {
        audioPlayer.setAudioSource(ConcatenatingAudioSource(
            children: [AudioSource.uri(Uri.parse(song!.songUrl))]));
        audioPlayer.play();
        isPlaying = true;
      }
    } else {
      audioPlayer.pause();
      isPlaying = false;
      paused = true;
    }
  }

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int pageIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomSheet: ValueListenableBuilder(
        valueListenable: widget.songWatch,
        builder: (context, song, child) {
          return Padding(
            padding: EdgeInsets.all(1),
            child: ListTile(
              onTap: () => song != null
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SongScreen(
                              song: song!, audioPlayer: widget.audioPlayer)))
                  : {},
              leading: song == null
                  ? Icon(
                      Icons.question_mark_rounded,
                      color: Colors.white,
                    )
                  : Padding(
                      padding: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(song.imageUrl),
                      )),
              tileColor: Color.fromARGB(255, 27, 27, 27),
              title: song == null
                  ? Text(
                      "Not Playing",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      song.name,
                      style: TextStyle(color: Colors.white),
                    ),
              trailing: InkWell(
                  onTap: () {
                    widget.playpause();
                    setState(() {});
                  },
                  child: widget.isPlaying
                      ? Icon(
                          Icons.pause,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        )),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        backgroundColor: Colors.black12,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.queue_music),
            label: "Library",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: "Upload",
              backgroundColor: Colors.white),
        ],
      ),
      body: pages[pageIdx],
    );
  }
}
