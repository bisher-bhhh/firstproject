import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetInfo {
  static final internetConnection = InternetConnection()
    ..onStatusChange.listen((InternetStatus status) {
      isConnect = switch (status) {
        InternetStatus.connected => true,
        _ => false,
      };
    });

  static Future<bool> get initState => internetConnection.hasInternetAccess;
  static bool isConnect = true;
}
