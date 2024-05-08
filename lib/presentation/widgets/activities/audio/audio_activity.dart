import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_end_button.dart';

class AudioActivity extends StatelessWidget {
  const AudioActivity(
      {super.key, required this.pageController, required this.activity});

  final PageController pageController;
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        ActivityIntroText(text: activity.descriptionEs),
        AudioActivityStepTwo(
          pageController: pageController,
        ),
      ],
    );
  }
}

class AudioActivityStepTwo extends StatefulWidget {
  const AudioActivityStepTwo({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<AudioActivityStepTwo> createState() => _AudioActivityStepTwoState();
}

class _AudioActivityStepTwoState extends State<AudioActivityStepTwo> {
  bool _showShareButton = false;

  void convertAudioToBase64(String path) async {
    // Lee el archivo de audio en bytes
    if (path == '') return;
    File audioFile = File(path);
    Uint8List bytes = await audioFile.readAsBytes();

    // Convierte los bytes a una cadena Base64
    String base64String = base64Encode(bytes);

    // Hacer algo con la cadena Base64, como enviarla a un servidor
    print("Audio en Base64: $base64String");
  }

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("00:00"),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[300],
                ),
                child: Slider(
                  value: 70,
                  max: 155,
                  onChanged: (value) {},
                ),
              ),
            ),
            const Text("02:35"),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           CircleIconActivity(
              iconData: Icons.play_arrow_rounded,
              onPressed: () {},
            ),
          ],
        ),
      
        const SizedBox(
          height: 50,
        ),
        const ActivityEndButton(isVisible: true),

      ],
    );
  }
}
