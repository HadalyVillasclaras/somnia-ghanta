import 'package:ghanta/domain/entities/phase.dart';

class Course {
  final int id;
  final String titleEs;
  final String titleCa;
  final double price;
  final String image;
  final String descriptionEs;
  final String descriptionCa;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final int? currentPhase;
  final int? totalPhases;
  final int? currentSubphase;
  final int? totalSubphases;
  final String? category;
  final List<Phase> phases;

  Course({
    required this.id,
    required this.titleEs,
    required this.titleCa,
    required this.price,
    required this.image,
    required this.descriptionEs,
    required this.descriptionCa,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.currentPhase,
    this.totalPhases,
    this.currentSubphase,
    this.totalSubphases,
    this.phases = const [],
    this.category,
  });

@override
  String toString() {
    return 'Course(id: $id, titleEs: $titleEs, titleCa: $titleCa, price: $price, image: $image, '
           'descriptionEs: $descriptionEs, descriptionCa: $descriptionCa, userId: $userId, '
           'createdAt: $createdAt, updatedAt: $updatedAt, currentPhase: $currentPhase, '
           'totalPhases: $totalPhases, currentSubphase: $currentSubphase, totalSubphases: $totalSubphases, '
           'category: $category, phases: $phases)';
  }

  
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
}
