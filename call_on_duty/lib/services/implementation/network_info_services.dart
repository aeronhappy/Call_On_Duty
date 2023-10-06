import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../contract/i_network_info_services.dart';

class NetworkInfoServices implements INetworkInfoServices {
  final InternetConnectionChecker connectionChecker;
  NetworkInfoServices(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
