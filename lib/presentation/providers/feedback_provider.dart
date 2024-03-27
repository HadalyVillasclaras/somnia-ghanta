import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/datasources/feedback_datasource_impl.dart';

final feedbackProvider =
    StateNotifierProvider<FeedbackNotifier, List<Feedback>>((ref) {
  return FeedbackNotifier();
});

class FeedbackNotifier extends StateNotifier<List<Feedback>> {
  FeedbackNotifier() : super(<Feedback>[]);

  final FeedbackDatasource _feedbackDatasource = FeedbackDatasourceImpl();

   bool isLoading = true;

  Future<void> getUserFeedback(String userToken) async {
    isLoading = true;
    final feedbacks = await _feedbackDatasource.getUserFeedback(userToken);
    state = feedbacks; 
    isLoading = false;
  }





}
