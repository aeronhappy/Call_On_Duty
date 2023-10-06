import 'package:dio/dio.dart';

late Dio client;

const String apiBaseAddress =
    'https://theonebibleappdevelopment.azurewebsites.net/';

void initializeClient({String? token}) {
  client = Dio();
  client.options.baseUrl = apiBaseAddress;
  client.options.headers = <String, dynamic>{
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
  };
  client.options.contentType = 'application/json';
}

/// Staging
/// 'https://theonebibleapp-staging.azurewebsites.net/';
 
/// Production
/// 'https://theonebibleapp.azurewebsites.net/';

/// Development
/// 'https://theonebibleappdevelopment.azurewebsites.net/';