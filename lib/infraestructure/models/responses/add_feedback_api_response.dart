import 'package:ghanta/infraestructure/models/api_models/feedback_api.dart';

class AddFeedbackApiResponse {
  final FeedbackApiModel data;
  final bool status;
  final String message;
  final int code;

  AddFeedbackApiResponse({
    required this.data,
    required this.status,
    required this.message,
    required this.code,
  });

  factory AddFeedbackApiResponse.fromJson(Map<String, dynamic> json) {
    return AddFeedbackApiResponse(
      data: FeedbackApiModel.fromJson(json["data"]),
      status: json["status"],
      message: json["message"],
      code: json["code"],
    );
  }
}