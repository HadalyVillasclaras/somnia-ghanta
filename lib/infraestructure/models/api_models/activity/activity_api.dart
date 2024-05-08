import 'package:ghanta/infraestructure/models/api_models/activity/activity_typology_api.dart';
import 'package:ghanta/infraestructure/models/api_models/subphase_api.dart';

class ActivityApiModel {
  final int id;
  final String titleEs;
  final String titleCa;
  final int order;
  final String descriptionEs;
  final String descriptionCa;
  final String imageUrlEs;
  final String imageUrlCa;
  final String videoUrlEs;
  final String videoUrlCa;
  final String audioUrlEs;
  final String audioUrlCa;
  final int subphaseId;
  final SubphaseApiModel? subphase;
  final ActivityTypologyApi? activityTypology;
  final int activityTypologyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TinderData> activityTinderData;
  final List<PopupData> activityPopupData;
  final String activityTextData;


  ActivityApiModel({
    required this.id,
    required this.titleEs,
    required this.titleCa,
    required this.order,
    required this.descriptionEs,
    required this.descriptionCa,
    required this.imageUrlEs,
    required this.imageUrlCa,
    required this.videoUrlEs,
    required this.videoUrlCa,
    required this.audioUrlEs,
    required this.audioUrlCa,
    required this.subphaseId,
    required this.subphase,
    required this.activityTypology,
    required this.activityTypologyId,
    required this.createdAt,
    required this.updatedAt,
    required this.activityTinderData,
    required this.activityPopupData,
    required this.activityTextData,
  });

  factory ActivityApiModel.fromJson(Map<String, dynamic> json) =>
      ActivityApiModel(
        id: json["id"],
        titleEs: json["title_es"],
        titleCa: json["title_ca"],
        order: json["order"],
        descriptionEs: json["description_es"],
        descriptionCa: json["description_ca"],
        imageUrlEs: json["image_url_es"] ?? "",
        imageUrlCa: json["image_url_ca"] ?? "",
        videoUrlEs: json["video_url_es"] ?? "",
        videoUrlCa: json["video_url_ca"] ?? "",
        audioUrlEs: json["audio_url_es"] ?? "",
        audioUrlCa: json["audio_url_ca"] ?? "",
        subphaseId: json["subphase_id"],
        subphase: json["subphase"] != null
            ? SubphaseApiModel.fromJson(json["subphase"])
            : null,
        activityTypology: json["activity_typology"] != null
            ? ActivityTypologyApi.fromJson(json["activity_typology"])
            : null,
        // activityTypologyId: json["activity_typology_id"], esto daba error
        activityTypologyId: json["activity_typology_id"] ?? 0,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        activityTinderData: json['activity_tinder_data'] != null
            ? List<TinderData>.from(
                json['activity_tinder_data'].map((x) => TinderData.fromJson(x)))
            : [],
        activityPopupData: json['activity_popup_data'] != null
            ? List<PopupData>.from(
                json['activity_popup_data'].map((x) => PopupData.fromJson(x)))
            : [],
        activityTextData: json["activity_text_data"] ?? "",
        
      );
}

class TinderData {
  final int id;
  final int activityId;
  final String cardTextEs;
  final String cardTextCa;
  final String popupTextEs;
  final String popupTextCa;
  final int order;

  TinderData({
    required this.id,
    required this.activityId,
    required this.cardTextEs,
    required this.cardTextCa,
    required this.popupTextEs,
    required this.popupTextCa,
    required this.order,
  });

  factory TinderData.fromJson(Map<String, dynamic> json) {
    return TinderData(
      id: json['id'],
      activityId: json['activity_id'],
      cardTextEs: json['card_text_es'],
      cardTextCa: json['card_text_ca'],
      popupTextEs: json['popup_text_es'],
      popupTextCa: json['popup_text_ca'],
      order: json['order'],
    );
  }
}

class PopupData {
  final int id;
  final int activityId;
  final String titleTextEs;
  final String titleTextCa;
  final String popupTextEs;
  final String popupTextCa;
  final int order;

  PopupData({
    required this.id,
    required this.activityId,
    required this.titleTextEs,
    required this.titleTextCa,
    required this.popupTextEs,
    required this.popupTextCa,
    required this.order,
  });

  factory PopupData.fromJson(Map<String, dynamic> json) {
    return PopupData(
      id: json['id'],
      activityId: json['activity_id'],
      titleTextEs: json['title_text_es'],
      titleTextCa: json['title_text_ca'],
      popupTextEs: json['popup_text_es'],
      popupTextCa: json['popup_text_ca'],
      order: json['order'],
    );
  }
}
