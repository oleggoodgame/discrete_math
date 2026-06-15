import 'package:discrete_math/core/auth/internet_connection/domain/entity/connection_type.dart';

abstract class ConnectivityRepository {
  Stream<ConnectionStatus> get connectionStatusStream;
  Future<ConnectionStatus> getCurrentStatus();
}