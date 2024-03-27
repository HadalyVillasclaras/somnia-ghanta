import 'package:ghanta/domain/_domain.dart';

class FeedbackRepositoryImpl extends FeedbackRepository {
  final FeedbackDatasource _datasource;

  FeedbackRepositoryImpl(this._datasource);

  @override
  Future<List<Feedback>> getUserFeedback(String userToken) {
    return _datasource.getUserFeedback(userToken);
  }
  
}