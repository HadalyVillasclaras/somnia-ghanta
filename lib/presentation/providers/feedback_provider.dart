import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/datasources/feedback_datasource_impl.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
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
      if (emotion <= 0) {
        throw Exception("Por favor, selecciona un emoji.");
      }

      final date = DateTime.now();
      await _feedbackDatasource.addUserFeedback(_userToken, activityId, _userId, date, emotion + 1, feedback);
      state = state.copyWith(submissionMessage: "La información ha sido guardada correctamente en el calendario.", isSubmitted: true, hasError: false);
    } catch (e) {
      if (e is Exception) {
      String message = e.toString().replaceFirst('Exception: ', '');
      state = state.copyWith(isSubmitted: true, hasError: true, submissionMessage: message);
    } else {
      state = state.copyWith(isSubmitted: true, hasError: true, submissionMessage: "Se ha producido un error y la información no ha podido ser guardada.");
    }
    }
  }

  void onFeedbackChanged(String feedback) {
    state = state.copyWith(feedback: feedback, isSubmitted: false);
  }

  void onEmotionChanged(int emotion) {
    state = state.copyWith(emotion: emotion, isSubmitted: false);
  }

  void resetSubmission() {
    state = state.copyWith(isSubmitted: false, submissionMessage: null, feedback: "", emotion: -1, hasError: false);
  }
}


class FeedbackFormState {
  final String feedback;
  final int emotion;
  final String? submissionMessage;
  final bool isSubmitted;
  final bool hasError;

  FeedbackFormState({
    this.feedback = '',
    this.emotion = 0,
    this.submissionMessage,
    this.isSubmitted = false,
    this.hasError = false,
  });

  FeedbackFormState copyWith({
    String? feedback,
    int? emotion,
    String? submissionMessage,
    bool? isSubmitted,
    bool? hasError,

  }) {
    return FeedbackFormState(
      feedback: feedback ?? this.feedback,
      emotion: emotion ?? this.emotion,
      submissionMessage: submissionMessage ?? this.submissionMessage,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      hasError: hasError ?? this.hasError,
    );
  }
}