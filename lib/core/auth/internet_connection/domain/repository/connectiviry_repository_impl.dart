import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:discrete_math/core/auth/internet_connection/data/repository/connectivity_repository.dart';
import 'package:discrete_math/core/auth/internet_connection/domain/entity/connection_type.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity connectivity;

  ConnectivityRepositoryImpl(this.connectivity);

  @override
  Stream<ConnectionStatus> get connectionStatusStream {
    return connectivity.onConnectivityChanged.map(_mapResultsToStatus);
  }

  @override
  Future<ConnectionStatus> getCurrentStatus() async {
    final results = await connectivity.checkConnectivity();
    return _mapResultsToStatus(results);
  }

  ConnectionStatus _mapResultsToStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      return ConnectionStatus.wifi;
    } else if (results.contains(ConnectivityResult.mobile)) {
      return ConnectionStatus.mobile;
    } else {
      return ConnectionStatus.disconnected;
    }
  }
}