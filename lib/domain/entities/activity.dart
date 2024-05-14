import 'package:flutter/material.dart';
import 'package:ghanta/infraestructure/models/api_models/activity/activity_api.dart';
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
  final String descriptionEs;
  final String descriptionCa;
  final int subphaseId;
  final int order;
  final ActivityType activityTypology;
  final int? activityTypologyId;
  final List<TinderData>? tinderData;
  final List<PopupData>? popupData;
  final String? textData;


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
    required this.descriptionEs,
    required this.descriptionCa,
    required this.subphaseId,
    required this.order,
    required this.activityTypology,
    this.activityTypologyId,
    this.tinderData,
    this.popupData,
    this.textData,
  });

 Widget getIconByType() {
    switch (activityTypologyId) {
      case 1: 
        return Image.asset('assets/icons/activity_icons/tinder.png', width: 22, height: 22);
      case 3:
        return Image.asset('assets/icons/activity_icons/texto.png', width: 22, height: 22);
      case 5:
        return Image.asset('assets/icons/activity_icons/pop_up.png', width: 22, height: 22);
      case 6:
        return Image.asset('assets/icons/activity_icons/voice_record.png', width: 22, height: 22);
      case 9:
        return Image.asset('assets/icons/activity_icons/meditacion.png', width: 22, height: 22);
      case 10:
        return Image.asset('assets/icons/activity_icons/podcast.png', width: 22, height: 22);
      default:
        return Image.asset('assets/icons/activity_icons/meditacion.png', width: 22, height: 22); 
      }
  }

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
}