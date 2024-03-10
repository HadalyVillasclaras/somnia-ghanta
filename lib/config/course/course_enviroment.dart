class CourseEnviroment {
  static const horizontalOddSeparation = 150.0;
  static const horizontalEvenSeparation = 50.0;

  static const verticalSeparation = 300.0;

  static double getHorizontalSeparation(int i) {
    return i.isEven
        ? CourseEnviroment.horizontalEvenSeparation
        : CourseEnviroment.horizontalOddSeparation;
  }

  static double getVerticalSeparation(int i) {
    return i == 0
                      ? 40
                      : i *
                          CourseEnviroment
                              .verticalSeparation;
  }
}
