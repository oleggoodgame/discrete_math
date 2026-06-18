
part of'eulirian_bloc.dart';
sealed class EulirianState {}

class EulirianInitial extends EulirianState {}

class EulirianProcessing extends EulirianState {}

class EulirianResult extends EulirianState {
  final EulerianType type;

  EulirianResult({
    required this.type,
  });
}