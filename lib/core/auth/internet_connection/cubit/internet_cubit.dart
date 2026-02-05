import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:discrete_math/core/auth/internet_connection/state/internet_state.dart';
import 'package:discrete_math/core/auth/internet_connection/type/connection_type.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    _subscription = _monitorInternetConnection();
  }

  StreamSubscription<List<ConnectivityResult>> _monitorInternetConnection() {
    print('📡 InternetCubit: start listening...');

    return connectivity.onConnectivityChanged.listen(
      (results) {
        print('🔁 onConnectivityChanged fired');
        print('📦 Raw results: $results');

        if (results.contains(ConnectivityResult.wifi)) {
          print('✅ WIFI detected');
          emit(InternetConnected(connectionType: ConnectionType.Wifi));
        } else if (results.contains(ConnectivityResult.mobile)) {
          print('📱 MOBILE detected');
          emit(InternetConnected(connectionType: ConnectionType.Mobile));
        } else {
          print('❌ NO INTERNET');
          emit(InternetDisconnected());
        }
      },
      onError: (error) {
        print('🔥 Connectivity error: $error');
      },
      onDone: () {
        print('🛑 Connectivity stream closed');
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
