part of 'internet_cubit.dart';

sealed class ConnectivityState {}

final class ConnectivityLoading extends ConnectivityState {}

final class ConnectivityConnected extends ConnectivityState {
  final ConnectionStatus status;
  ConnectivityConnected(this.status);
}

final class ConnectivityDisconnected extends ConnectivityState {}
