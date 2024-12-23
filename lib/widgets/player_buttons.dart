import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mymusic/constants.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    Key? key,
    required this.audioPlayer,
    }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              StreamBuilder<SequenceState?>(
                stream: audioPlayer.sequenceStateStream,
                builder: (context, snapshot) {
                  return IconButton(onPressed: audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null, iconSize: 45,icon: Icon(Icons.skip_previous, color: Colors.white),);
                }), 
                          StreamBuilder(
              stream: audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final playerState = snapshot.data;
                  final processingState = (playerState! as PlayerState).processingState;

                  if (processingState == ProcessingState.loading || 
                      processingState == ProcessingState.buffering) {
                        return Container(
                          width: 64.0,
                          height: 64.0,
                          margin: const EdgeInsets.all(10.0),
                          child: const CircularProgressIndicator(),
                        );
                  } else if (audioPlayer.playing){
                    return IconButton(
                      onPressed: () => audioPlayer.pause(), 
                      iconSize: 75,
                      icon: Icon(Icons.pause_circle, color: Colors.white,)
                      );
                  } else if (processingState != ProcessingState.completed){
                    return IconButton(
                      onPressed: () => audioPlayer.play(), 
                      iconSize: 75,
                      icon: Icon(Icons.play_circle, color: Colors.white,)
                      );
                  } else {
                    return IconButton(onPressed: () => audioPlayer.seek(Duration.zero, index: audioPlayer.effectiveIndices!.first), iconSize: 45, icon: const Icon(Icons.replay_circle_filled));
                
                  }
                } else {
                  return const CircularProgressIndicator(color: Colors.white,);
                }
              }), 
              StreamBuilder<SequenceState?>(
                stream: audioPlayer.sequenceStateStream,
                builder: (context, snapshot) {
                  return IconButton(onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null, iconSize: 45,icon: Icon(Icons.skip_next, color: Colors.white),);
                }
              ),
            ],
          );
  }
}