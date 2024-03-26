import 'package:ghanta/domain/_domain.dart';

abstract class FeedbackRepository {
  Future<(List<Feedback>, String)> getUserFeedback(String userToken);

}