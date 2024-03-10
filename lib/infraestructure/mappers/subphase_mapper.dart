import 'package:ghanta/domain/entities/subphase.dart';
import 'package:ghanta/infraestructure/mappers/activity_mapper.dart';
import 'package:ghanta/infraestructure/models/api_models/subphase_api.dart';

class SubphaseMapper {
  static Subphase subphaseApiModelToEntity(SubphaseApiModel subphaseApiModel) =>
      Subphase(
          id: subphaseApiModel.id,
          titleEs: subphaseApiModel.titleEs,
          titleCa: subphaseApiModel.titleCa,
          estimatedTime: int.parse(subphaseApiModel.estimatedTime),
          phaseId: subphaseApiModel.phaseId,
          order: subphaseApiModel.order,
          subphaseTypologyId: subphaseApiModel.subphaseTyplogyId,
          type: subphaseApiModel.type == 'normal'
              ? SubphaseType.normal
              : SubphaseType.achievement,
          activities: subphaseApiModel.activities
              .map((activity) => ActivityMapper.apiModelToEntity(activity))
              .toList());
}
