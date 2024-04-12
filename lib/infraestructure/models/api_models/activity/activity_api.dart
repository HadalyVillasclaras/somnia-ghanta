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
          subphase: json["subphase"] != null ? SubphaseApiModel.fromJson(json["subphase"]) : null,
          activityTypology: json["activity_typology"] != null ? ActivityTypologyApi.fromJson(
              json["activity_typology"]) : null,
          // activityTypologyId: json["activity_typology_id"], esto daba error
          activityTypologyId: json["activity_typology_id"] ?? 0,
          createdAt: DateTime.parse(json["created_at"]),
          updatedAt: DateTime.parse(json["updated_at"]));
}
