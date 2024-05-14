import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/infraestructure/models/api_models/activity/activity_api.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';

class ActivityMapper {
  static Activity apiModelToEntity(ActivityApiModel api) => Activity(
      id: api.id,
      titleEs: api.titleEs,
      titleCa: api.titleCa,
      descriptionEs: api.descriptionEs,
      descriptionCa: api.descriptionCa,
      subphaseId: api.subphaseId,
      audioUrlES: api.audioUrlEs,
      audioUrlCA: api.audioUrlCa,
      order: api.order,
      activityTypologyId: api.activityTypologyId, 
      activityTypology:
          ActivityTypologyMapper.apiModelToEntity(api.activityTypology?.id),
      tinderData: api.activityTinderData,
      popupData: api.activityPopupData,
      textData: api.activityTextData
   );
}

class ActivityTypologyMapper {
  static ActivityType apiModelToEntity(dynamic id) {
    switch (id) {
      case 1:
        return ActivityType.tinder;
      case 3:
        return ActivityType.text;
      case 5:
        return ActivityType.popup;
      case 6:
        return ActivityType.voiceRecorder;
      case 9:
        return ActivityType.meditation;
      case 10:
        return ActivityType.audio;
      default:
        return ActivityType.meditation;
    }
  }
}

