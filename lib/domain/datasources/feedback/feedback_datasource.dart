import 'package:ghanta/domain/_domain.dart';

abstract class FeedbackDatasource {
  Future<(List<Feedback>, String)> getUserFeedback(String userToken);
}