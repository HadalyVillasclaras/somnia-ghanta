import 'package:ghanta/domain/_domain.dart';

abstract class FeedbackRepository {
  Future<List<UserFeedback>> getUserFeedback(int userId, String userToken);

}