import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fancy_audio_recorder/audio_recorder_button.dart';
import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';
import 'package:ghanta/presentation/widgets/activities/shared/activity_intro_text.dart';

class AudioActivity extends StatelessWidget {
  const AudioActivity({Key? key, required this.pageController})
      : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        const ActivityIntroText(
            text:'Duis a lacus convallis, sagittis erat nec, lobortis urna. Fusce ac risus malesuada, consectetur magna et, scelerisque felis. Phasellus laoreet scelerisque facilisis. Duis luctus sollicitudin semper. Aenean viverra enim eget enim euismod, vitae aliquet libero semper.'),
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
                  onChanged: (value) {
                  },
                ),
              ),
            ),
            const Text("02:35"), 
          ],
        ),
        // const Text("01:35"), 
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(
        //       child: SliderTheme(
        //         data: SliderTheme.of(context).copyWith(
        //           thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),  // Hide the thumb
        //           trackHeight: 2.0,  
        //           inactiveTrackColor: Colors.grey[300],  // Color behind the progress
        //           overlayColor: Colors.transparent,  // No overlay
        //         ),
        //         child: Stack(
        //           alignment: Alignment.center,
        //           children: [
        //             Slider(
        //               value: 75, 
        //               max: 150, 
        //               onChanged: (value) {},
        //             ),
        //             Positioned(
        //               child: Container(
        //                 height: 20,  
        //                 width: 2, 
        //                 color: ColorsTheme.primaryColorBlue,  
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: () {},
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 45),
              decoration: const BoxDecoration(
                color: ColorsTheme.primaryColorBlue,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                iconSize: 44,
                icon: const Icon(Icons.play_arrow),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: () {},
            ),
          ],
        ),
        // AudioRecorderButton(
        //   maxRecordTime: const Duration(minutes: 2),
        //   primaryColor: ColorsTheme.primaryColorBlue,
        //   iconColor: Colors.white,
        //   onRecordComplete: (path) {
        //     //Transfor the path to a base64 string
        //     convertAudioToBase64(path ?? '');

        //     if (path != null) {
        //       setState(() {
        //         _showShareButton = true;
        //       });
        //     } else {
        //       setState(() {
        //         _showShareButton = false;
        //       });
        //     }
        //   },
        // ),
        const SizedBox(
          height: 50,
        ),
        Visibility(
          // visible: _showShareButton,
          visible: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.fromLTRB(0, 2, 15, 2)),
                onPressed: () {},
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
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.fromLTRB(15, 2, 0, 2)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AudioShareModal();
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Seguir'),
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
      ],
    );
  }
}

class AudioShareModal extends StatelessWidget {
  const AudioShareModal({
    super.key,
  });

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
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
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
                      onPressed: () {
                        Navigator.of(context).pop();
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
