import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworlsInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworlsInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
