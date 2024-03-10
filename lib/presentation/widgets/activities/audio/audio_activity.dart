import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fancy_audio_recorder/audio_recorder_button.dart';
import 'package:flutter/material.dart';
import 'package:ghanta/config/constants/colors_theme.dart';
import 'package:ghanta/presentation/widgets/_widgets.dart';

class AudioActivity extends StatelessWidget {
  const AudioActivity({Key? key, required this.pageController})
      : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        const AudioActivityStepOne(),
        AudioActivityStepTwo(
          pageController: pageController,
        ),
      ],
    );
  }
}

class AudioActivityStepOne extends StatelessWidget {
  const AudioActivityStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityBody(
        child: Column(
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.9),
            child: const ActivityTextBody(
                'Aqui ira un comentario dinamico sobre la actividad de audio')),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
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
        child: Column(
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.9),
          child: Column(
            children: [
              // const ActivityTextBody('Expresa tus sentimientos con un audio'),
              const SizedBox(
                height: 20,
              ),
              AudioRecorderButton(
                maxRecordTime: const Duration(minutes: 2),
                primaryColor: ColorsTheme.primaryColorBlue,
                iconColor: Colors.white,
                onRecordComplete: (path) {
                  //Transfor the path to a base64 string
                  convertAudioToBase64(path ?? '');

                  if (path != null) {
                    setState(() {
                      _showShareButton = true;
                    });
                  } else {
                    setState(() {
                      _showShareButton = false;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _showShareButton,
                child: FilledButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AudioShareModal();
                      },
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: ColorsTheme.primaryColorBlue,
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
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
        padding: const EdgeInsets.all(20),
        width: MediaQuery.sizeOf(context).width * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              const Text(
                  '¿Quieres este audio y comunicar tus palabras a la persona que has elegido?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: ColorsTheme.primaryColorBlue,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Observa cómo te sientes al apreciar y reconocer a los demás, y cómo te sientes al recibir sus respuestas.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: ColorsTheme.primaryColorBlue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: ColorsTheme.primaryColorBlue,
                      ),
                      child: const Text(
                        'Compartir',
                        style: TextStyle(color: Colors.white),
                      ),
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
