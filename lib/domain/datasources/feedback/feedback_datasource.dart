import 'package:ghanta/domain/_domain.dart';

abstract class FeedbackDatasource {
  Future<List<UserFeedback>> getUserFeedback(int userId, String userToken);
}