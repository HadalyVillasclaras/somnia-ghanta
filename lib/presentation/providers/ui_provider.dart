

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_tooltip/super_tooltip.dart';

final phasesTooltipsProvider = Provider((ref) => <SuperTooltipController>[]);

final navbarTransparentProvider = FutureProvider.family((ref, int index) async {
  return index == 0 || index == 3;
});

final showLogoProvider = FutureProvider.family((ref, int index) async {
  return index != 3;
});