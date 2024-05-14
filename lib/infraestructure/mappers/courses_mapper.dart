import 'package:ghanta/domain/_domain.dart';
import 'package:ghanta/infraestructure/mappers/phases_mapper.dart';
import 'package:ghanta/infraestructure/models/api_models/course_api.dart';

class CoursesMapper {

  static Course coursesApiModelToEntity (CourseApiModel courseApiModel) {
    return Course(
      id: courseApiModel.id,
      titleEs: courseApiModel.titleEs,
      titleCa: courseApiModel.titleCa,
      price: courseApiModel.price.toDouble(),
      image: courseApiModel.image,
      descriptionEs: courseApiModel.descriptionEs,
      descriptionCa: courseApiModel.descriptionCa,
      userId: courseApiModel.userId.toString(),
      createdAt: courseApiModel.createdAt.toString(),
      updatedAt: courseApiModel.updatedAt.toString(),
      currentPhase: courseApiModel.currentCourseStatus?.currentPhase ?? 1,
      currentSubphase:  courseApiModel.currentCourseStatus?.currentSubphase ?? 1,
      totalPhases: courseApiModel.phases.length,
      totalSubphases: courseApiModel.phases.isNotEmpty ? courseApiModel.phases.map((e) => e.subphases!.length).reduce((value, element) => value + element) : 1,
      phases: courseApiModel.phases.map((e) => PhaseMapper.phasesApiModelToEntity(e)).toList(),
    );
  }
}