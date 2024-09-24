import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnectionWithInternet() async {
  final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

  bool result = !connectivityResult.contains(ConnectivityResult.none);
  log("connection to internet: $result");
  return result;
}
