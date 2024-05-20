import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:ghanta/presentation/widgets/activities/shared/recorded_audio_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
class VoiceRecorderActivity extends StatelessWidget {
  const VoiceRecorderActivity(
      {super.key, required this.pageController, required this.activity});

  final PageController pageController;
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        ActivityIntroText(text: activity.descriptionEs),
        VoiceRecorderActivityStepTwo(
          pageController: pageController,
        ),
      ],
    );
  }
}

class VoiceRecorderActivityStepTwo extends StatefulWidget {
  const VoiceRecorderActivityStepTwo({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<VoiceRecorderActivityStepTwo> createState() =>
      _VoiceRecorderActivityStepTwoState();
}

class _VoiceRecorderActivityStepTwoState
    extends State<VoiceRecorderActivityStepTwo> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  String? currentRecordingPath;
  bool isRecordingCompleted = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');

    setState(() {
      isRecordingCompleted = false;
    });
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    // final audioFile = File(path!);
    // print('recorded audio: $audioFile');

    setState(() {
      currentRecordingPath = path;
      isRecordingCompleted = true;
    });
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      // print("Microphone permission not granted");
    } else {
      await recorder.openRecorder();

      isRecorderReady = true;

      recorder.setSubscriptionDuration(
        const Duration(milliseconds: 500),
      );
    }
  }

Future<void> restartRecording() async {
  if (isRecorderReady) {
    if (currentRecordingPath != null) {
      final file = File(currentRecordingPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    setState(() {
      currentRecordingPath = null;
      isRecordingCompleted = false;
    });

    await initRecorder();  
  } else {
    await initRecorder();
  }
}

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      children: [
        
        if (!isRecordingCompleted) ...[
          StreamBuilder<RecordingDisposition>(
            stream: recorder.onProgress,
            builder: (context, snapshot) {
              final duration = snapshot.data?.duration ?? Duration.zero;
              String formattedTime = _formatDuration(duration);
              return Text(
                formattedTime,
                style: const TextStyle(
                  fontSize: 18,
                ),
              );
            },
          ),
          StreamBuilder(
            stream: recorder.onProgress,
            builder: (context, snapshot) {
              final recordingDuration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;
              return SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbColor: Theme.of(context).colorScheme.primary,
                    inactiveTrackColor: Colors.grey[300],
                    thumbShape: _SliderThumbShape()),
                child: Slider(
                  value: recordingDuration.inSeconds.toDouble(),
                  min: 0.0,
                  max: 180.0, //  maximum recording time
                  onChanged: (value) {},
                ),
              );
            },
          ),
          const SizedBox(
          height: 30,
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 35,
            child: IconButton(
                onPressed: () async {
                  if (recorder.isRecording) {
                    await stop();
                  } else {
                    await record();
                  }

                  setState(() {
                    // forces the UI to update after recording state changes
                  });
                },
                icon: Icon(recorder.isRecording ? Icons.stop : Icons.mic,
                    size: 35)),
          ),
          const SizedBox(
            height: 48,
          ),
        ],

        if (isRecordingCompleted && currentRecordingPath != null) ...[ 
          RecordedAudioPlayer(audioPath: currentRecordingPath!),
        const SizedBox(
          height: 0,
        ),
        Visibility(
          // visible: _showShareButton,
          visible: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.fromLTRB(0, 2, 15, 2)),
                 onPressed: restartRecording,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: 40,
                    ),
                    SizedBox(width: 4),
                    Text('Repetir'),
                  ],
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.fromLTRB(15, 2, 0, 2)),
                onPressed: () {
                  final String? recordingPath = currentRecordingPath;
                 if (recordingPath != null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AudioShareModal(currentRecordingPath: recordingPath);
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ha habido un error. No se puede compartir el audio."))
                  );
                }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Finalizar'),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ]
      ],
    );
  }
}

class AudioShareModal extends StatefulWidget {
  const AudioShareModal({
    super.key,
    required this.currentRecordingPath
  });

  final String currentRecordingPath;

  @override
  State<AudioShareModal> createState() => _AudioShareModalState();
}

class _AudioShareModalState extends State<AudioShareModal> {
Future<bool> checkAndRequestPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  return status.isGranted;
}

Future<bool> shareAudio(BuildContext context, String filePath) async {
  bool isGranted = await checkAndRequestPermission();
  if (!isGranted) {
    if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ghanta no tiene permisos para compartir."))
        );
      }
    return false;
  }

  final result = await Share.shareXFiles([
    XFile(filePath)
  ], text: 'He grabado un audio desde Ghanta');

  if (context.mounted) {
      if (result.status == ShareResultStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tu audio se ha compartido"))
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ha habido un error al compartir el audio."))
        );
      }
    }
     return false;
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        width: MediaQuery.sizeOf(context).width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Text(
                  '¿Quieres este audio y comunicar tus palabras a la persona que has elegido?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Observa cómo te sientes al apreciar y reconocer a los demás, y cómo te sientes al recibir sus respuestas.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                      ),
                      onPressed:  () async {
                        bool hasShared = await shareAudio(context, widget.currentRecordingPath);
                        if (!context.mounted) return; 
                        Navigator.of(context).pop();

                        if (hasShared == true) {
                          Navigator.of(context).pop(); 
                        }
                      },
                      child: const Text('Compartir'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(2, 0);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(sliderTheme.thumbColor != null);

    final rect = Rect.fromCenter(center: center, width: 2, height: 20);
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(2 / 2)),
      Paint()..color = sliderTheme.thumbColor!,
    );

    final circleCenter = Offset(center.dx, center.dy - 15);

    final circlePaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    context.canvas.drawCircle(
      circleCenter,
      4.0,
      circlePaint,
    );
  }
}
