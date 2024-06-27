// lib/shared/internet_connection.dart
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection {
  static Future<bool> isConnectedToInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
