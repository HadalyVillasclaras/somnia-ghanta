
import 'package:ghanta/domain/entities/subphase.dart';

class Phase {
  
  final int id;
  final String titleEs;
  final String titleCa;
  final int duration;
  final String descriptionEs;
  final String descriptionCa;
  final int courseId;
  final int order;
  final List<Subphase> subphases;

    /// Metodo para devolver el titulo dependiendo del idioma

  String getTitle({String lang = 'es'}) {
    if (lang == 'ca') {
      return titleCa;
    } else {
      return titleEs;
    }
  }

  /// Metodo para devolver la descripcion dependiendo del idioma

  String getDescription({String lang = 'es'}) {
    if (lang == 'ca') {
      return descriptionCa;
    } else {
      return descriptionEs;
    }
  }
  
  Phase({
    required this.id,
    required this.titleEs,
    required this.titleCa,
    required this.duration,
    required this.descriptionEs,
    required this.descriptionCa,
    required this.courseId,
    required this.order,
    required this.subphases,
  });
}
