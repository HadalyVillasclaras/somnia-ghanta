import 'package:ghanta/domain/entities/phase.dart';
import 'package:ghanta/infraestructure/mappers/subphase_mapper.dart';
import 'package:ghanta/infraestructure/models/api_models/phase_api.dart';

class PhaseMapper {
  static Phase phasesApiModelToEntity(PhaseApiModel phaseApiModel) => Phase(
      id: phaseApiModel.id,
      titleEs: phaseApiModel.titleEs,
      titleCa: phaseApiModel.titleCa,
      duration: phaseApiModel.duration,
      descriptionEs: phaseApiModel.descriptionEs ?? '',
      descriptionCa: phaseApiModel.descriptionCa ?? '',
      courseId: phaseApiModel.courseId,
      order: phaseApiModel.order,
      subphases: phaseApiModel.subphases == null
          ? []
          : phaseApiModel.subphases!
              .map((subphase) => SubphaseMapper.subphaseApiModelToEntity(subphase, phaseApiModel.courseId))
              .toList()
    );
}
