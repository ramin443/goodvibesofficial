import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesofficial/utils/common_functiona.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
  StreamController<ConnectivityStatus>.broadcast();

  ValueNotifier<ConnectivityStatus> appConnectionStatus = ValueNotifier(null);

  ConnectivityStatus previousConnectionStatus;

  ConnectivityService() {
    checkConnectionInitailly();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));

      if (result != null) {
        appConnectionStatus.value = _getStatusFromResult(result);
      }
    });
  }

  checkConnectionInitailly() async {
    final bool isOffline = await checkIfOffline();
    if (isOffline) {
      appConnectionStatus.value = ConnectivityStatus.Offline;
      previousConnectionStatus = ConnectivityStatus.Offline;
    } else {
      previousConnectionStatus = ConnectivityStatus.WiFi;
      appConnectionStatus.value = ConnectivityStatus.WiFi;
    }
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
    }
  }
}

enum ConnectivityStatus { Cellular, WiFi, Offline }
