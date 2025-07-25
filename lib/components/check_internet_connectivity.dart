import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectionStatusProvider =
StateNotifierProvider<ConnectionStatusNotifier, bool>(
      (ref) => ConnectionStatusNotifier(Connectivity()),
);

class ConnectionStatusNotifier extends StateNotifier<bool> {
  final Connectivity connectivity;

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  ConnectivityResult? _lastResult;

  ConnectionStatusNotifier(this.connectivity) : super(true) {
    _listenToConnectivityChanges();
  }

  void _listenToConnectivityChanges() {
    _subscription = connectivity.onConnectivityChanged.listen((results) {
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;

      if (_lastResult == result) return;
      _lastResult = result;

      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          _handleOnline();
          break;
        case ConnectivityResult.none:
          _handleOffline();
          break;
        default:
          break;
      }
    });
  }

  void _handleOnline() {
    if (!state) state = true;
  }

  void _handleOffline() {
    if (state) state = false;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
