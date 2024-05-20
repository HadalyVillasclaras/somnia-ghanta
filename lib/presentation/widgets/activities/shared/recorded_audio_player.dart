import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:audioplayers/audioplayers.dart';

class RecordedAudioPlayer extends StatefulWidget {
  const RecordedAudioPlayer({super.key,  required this.audioPath  });
  final String audioPath;

  @override
  State<RecordedAudioPlayer> createState() => _RecordedAudioPlayerState();
}

class _RecordedAudioPlayerState extends State<RecordedAudioPlayer> {
  late AudioPlayer audioPlayer;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool isPlaying = false;
  String? fullAudioUrl;
  bool isEndButtonVisible = false;

  StreamSubscription? positionSubscription;
  StreamSubscription? durationSubscription;
  StreamSubscription? playerStateSubscription;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    positionSubscription = audioPlayer.onPositionChanged.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });

    durationSubscription = audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          _duration = newDuration;
        });
      }
    });

 
    fullAudioUrl =   widget.audioPath;

    if (fullAudioUrl != null) {
      audioPlayer.setSourceUrl(fullAudioUrl!).catchError((error) {
        debugPrint('Error setting audio source: $error');
      });
    }

    playerStateSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          isEndButtonVisible = true; 
        });
      }
    });
  }

  @override
  void dispose() {
  positionSubscription?.cancel();
    durationSubscription?.cancel();
    playerStateSubscription?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes);
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             SizedBox(
              width: 50, 
              child: Text(
                formatDuration(_position),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[300],
                ),
             child: Slider(
                value: _position.inSeconds.toDouble() <= _duration.inSeconds.toDouble()
                         ? _position.inSeconds.toDouble()
                        : _duration.inSeconds.toDouble(),  
                max: _duration.inSeconds.toDouble() > 0 ? _duration.inSeconds.toDouble() : 1,
                onChanged: (value) {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              ),
              ),
            ),
            SizedBox(
              width: 50, 
              child: Text(
                formatDuration(_duration),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleIconActivity(
              iconData: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              onPressed: () {
                if (isPlaying) {
                  audioPlayer.pause(); 
                  setState(() {
                    isPlaying = false; 
                  });
                } else {
                  audioPlayer.play(UrlSource(fullAudioUrl!)).then((_) {
                    setState(() { isPlaying = true; });
                  });
                }
                            },
            ),
          ],
        ),
       
      ],
    );
  }
}