import 'package:ghanta/domain/_domain.dart';

abstract class FeedbackDatasource {
  Future<List<Feedback>> getUserFeedback(String userToken);
}