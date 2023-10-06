import 'package:call_on_duty/views/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:call_on_duty/helper/api_helper.dart' as api_helper;
import 'package:call_on_duty/repository/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  api_helper.initializeClient(token: '');
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call on Duty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const DashboardPage(),
    );
  }
}
