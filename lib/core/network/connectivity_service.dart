import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  const ConnectivityService(this._connectivity);

  final Connectivity _connectivity;

  Stream<List<ConnectivityResult>> watch() =>
      _connectivity.onConnectivityChanged;

  Future<bool> isOnline() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}
