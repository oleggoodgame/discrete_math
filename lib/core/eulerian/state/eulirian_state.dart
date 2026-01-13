import 'package:discrete_math/core/eulerian/type/eulirian_type.dart';

sealed class EulirianState {}

class EulirianInitial extends EulirianState {}

class EulirianProcessing extends EulirianState {}

class EulirianResult extends EulirianState {
  final EulerianType type;

  EulirianResult({
    required this.type,
  });
}