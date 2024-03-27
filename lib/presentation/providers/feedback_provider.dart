import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/config/constants/enviroment.dart';
import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/datasources/feedback_datasource_impl.dart';
import 'package:ghanta/presentation/providers/auth/auth_provider.dart';

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
