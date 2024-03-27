import 'package:ghanta/domain/_domain.dart';

abstract class FeedbackRepository {
  Future<List<Feedback>> getUserFeedback(String userToken);

}