import 'package:flutter/material.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';

class Activity {
  final int id;
  final String titleEs;
  final String titleCa;
  final String? imgUrlES;
  final String? imgUrlCA;
  final String? videoUrlES;
  final String? videoUrlCA;
  final String? audioUrlES;
  final String? audioUrlCA;
  final String? descriptionEs;
  final String? descriptionCa;
  final int subphaseId;
  final int order;
  final ActivityType activityTypology;

  /// Metodo para devolver el titulo dependiendo del idioma

  String getTitle({String lang = 'es'}) {
    if (lang == 'ca') {
      return titleCa;
    } else {
      return titleEs;
    }
  }

  /// Metodo para devolver la imagen dependiendo del idioma

  String? getImage({String lang = 'es'}) {
    if (lang == 'ca') {
      return imgUrlCA;
    } else {
      return imgUrlES;
    }
  }

  /// Metodo para devolver el video dependiendo del idioma

  String? getVideo({String lang = 'es'}) {
    if (lang == 'ca') {
      return videoUrlCA;
    } else {
      return videoUrlES;
    }
  }

  /// Metodo para devolver el audio dependiendo del idioma

  String? getAudio({String lang = 'es'}) {
    if (lang == 'ca') {
      return audioUrlCA;
    } else {
      return audioUrlES;
    }
  }

  /// Metodo para devolver la descripcion dependiendo del idioma

  String? getDescription({String lang = 'es'}) {
    if (lang == 'ca') {
      return descriptionCa;
    } else {
      return descriptionEs;
    }
  }

  Widget getIconByType() {
    switch (activityTypology) {
      case ActivityType.meditation:
        return const Icon(Icons.self_improvement);
      case ActivityType.audio:
        return const Icon(Icons.multitrack_audio_sharp);
      case ActivityType.tinder:
        return const Icon(Icons.calendar_view_month_sharp);
      case ActivityType.popup:
        return const Icon(Icons.info);
      default:
        return const Icon(Icons.self_improvement);
    }
  }

  Activity({
    required this.id,
    required this.titleEs,
    required this.titleCa,
    this.imgUrlES,
    this.imgUrlCA,
    this.videoUrlES,
    this.videoUrlCA,
    this.audioUrlES,
    this.audioUrlCA,
    this.descriptionEs,
    this.descriptionCa,
    required this.subphaseId,
    required this.order,
    required this.activityTypology,
  });
}
