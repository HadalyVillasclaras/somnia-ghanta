import 'package:ghanta/domain/entities/activity.dart';

enum SubphaseType { normal, achievement }

class Subphase {
  final int id;
  final String titleEs;
  final String titleCa;
  final int estimatedTime;
  final int phaseId;
  final int order;
  final int subphaseTypologyId;
  final SubphaseType type;
  final List<Activity> activities;

  Subphase({
    required this.id,
    required this.titleEs,
    required this.titleCa,
    required this.estimatedTime,
    required this.phaseId,
    required this.order,
    required this.subphaseTypologyId,
    required this.type,
    required this.activities,
  });

@override
  String toString() {
    return 'Subphase(id: $id, titleEs: $titleEs, titleCa: $titleCa, estimatedTime: $estimatedTime, '
           'phaseId: $phaseId, order: $order, subphaseTypologyId: $subphaseTypologyId, '
           'type: $type, activities: ${activities.map((a) => a.toString()).join(', ')})';
  }

  
  /// Metodo para devolver el titulo dependiendo del idioma

  String getTitle({String lang = 'es'}) {
    if (lang == 'ca') {
      return titleCa;
    } else {
      return titleEs;
    }
  }


}
