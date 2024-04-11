import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/datasources/feedback_datasource_impl.dart';
import 'package:ghanta/presentation/providers/auth/auth_provider.dart';

// USER FEEDBACK PROVIDER
final userFeedbackProvider = FutureProvider<List<UserFeedback>>((ref) async {
  final feedbackDatasource = FeedbackDatasourceImpl();

  final authState = ref.read(authProvider);
  final userToken = Environment.apiToken;
  final userId = authState.user?.id; 

    if (userId == null) {
      throw Exception("User not logged in");
    }

  final feedbacks = await feedbackDatasource.getUserFeedback(userId, userToken);

  return feedbacks;
});


// FEEDBACK PROVIDER
final feedbackProvider = StateNotifierProvider<FeedbackNotifier, FeedbackFormState>((ref) {
  final authState = ref.read(authProvider);
  final userId = authState.user!.id;
  final userToken = authState.user!.token;

  return FeedbackNotifier(FeedbackDatasourceImpl(), userToken!, userId);
});

class FeedbackNotifier extends StateNotifier<FeedbackFormState> {
  final FeedbackDatasource _feedbackDatasource;
  final String _userToken;
  final int _userId;

  FeedbackNotifier(this._feedbackDatasource, this._userToken, this._userId) : super(FeedbackFormState());

  Future<void> submitFeedback(int activityId) async {
    await addFeedback(
      activityId: activityId,
      emotion: state.emotion,
      feedback: state.feedback,
    );
  }

  Future<void> addFeedback({
    required int activityId,
    required int emotion,
    required String feedback,
  }) async {
    try {
      final date = DateTime.now();
      await _feedbackDatasource.addUserFeedback(_userToken, 1, _userId, date, emotion + 1, feedback);
      state = state.copyWith(submissionMessage: "La información ha sido guardada correctamente en el calendario.", isSubmitted: true);
    } catch (e) {
      state = state.copyWith(isSubmitted: true, submissionMessage: "Se ha producido un error y la información no ha podido ser guardada.");
    }
  }

  void onFeedbackChanged(String feedback) {
    state = state.copyWith(feedback: feedback);
  }

  void onEmotionChanged(int emotion) {
    state = state.copyWith(emotion: emotion);
  }

  void resetSubmission() {
    state = state.copyWith(isSubmitted: false, submissionMessage: null, feedback: "", emotion: -1);
  }
}


class FeedbackFormState {
  final String feedback;
  final int emotion;
  final String? submissionMessage;
  final bool isSubmitted;

  FeedbackFormState({
    this.feedback = '',
    this.emotion = 0,
    this.submissionMessage,
    this.isSubmitted = false,
  });

  FeedbackFormState copyWith({
    String? feedback,
    int? emotion,
    String? submissionMessage,
    bool? isSubmitted,
  }) {
    return FeedbackFormState(
      feedback: feedback ?? this.feedback,
      emotion: emotion ?? this.emotion,
      submissionMessage: submissionMessage ?? this.submissionMessage,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}