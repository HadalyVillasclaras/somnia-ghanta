import 'package:ghanta/domain/entities/activity.dart';
import 'package:ghanta/infraestructure/models/api_models/activity/activity_api.dart';
import 'package:ghanta/presentation/screens/_presentation.dart';

class ActivityMapper {
  static Activity apiModelToEntity(ActivityApiModel api) => Activity(
      id: api.id,
      titleEs: api.titleEs,
      titleCa: api.titleCa,
      subphaseId: api.subphaseId,
      order: api.order,
      activityTypology:
          ActivityTypologyMapper.apiModelToEntity(api.activityTypology?.id));
}

class ActivityTypologyMapper {
  static ActivityType apiModelToEntity(dynamic id) {
    switch (id) {
      case 1:
        return ActivityType.tinder;
      case 2:
        return ActivityType.audio;
      case 3:
        return ActivityType.draggable;
      case 4:
        return ActivityType.audio;
      case 5:
        return ActivityType.popup;
      case 6:
        return ActivityType.meditation;
      default:
        return ActivityType.audio;
    }
  }
}
