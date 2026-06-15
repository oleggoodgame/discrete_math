import 'dart:async';

import 'package:discrete_math/core/auth/internet_connection/domain/repository/connectivity_repository.dart';
import 'package:discrete_math/core/auth/internet_connection/domain/entity/connection_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final ConnectivityRepository repository;
  StreamSubscription<ConnectionStatus>? _subscription;

  ConnectivityCubit(this.repository) : super(ConnectivityLoading()) {
    _init();
  }

  Future<void> _init() async {
    final initialStatus = await repository.getCurrentStatus();
    emit(_mapStatusToState(initialStatus));

    _subscription = repository.connectionStatusStream.listen((status) {
      emit(_mapStatusToState(status));
    });
  }

  ConnectivityState _mapStatusToState(ConnectionStatus status) {
    return switch (status) {
      ConnectionStatus.wifi || ConnectionStatus.mobile => ConnectivityConnected(status),
      ConnectionStatus.disconnected => ConnectivityDisconnected(),
    };
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}