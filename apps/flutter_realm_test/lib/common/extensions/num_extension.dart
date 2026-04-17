import 'dart:math' as math;

extension RadianExtension on num {
  double get toRadians => this * math.pi / 180.0;
}

extension TurnExtension on num {
  double get toTurns => this / 360.0;
}
