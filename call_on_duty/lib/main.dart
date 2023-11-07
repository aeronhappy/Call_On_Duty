import 'package:call_on_duty/views/dashboard_page.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:call_on_duty/repository/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late AppLifecycleState appLifecycle;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      stopMusic();
    }

    if (state == AppLifecycleState.resumed) {
      playMusic();
    }
  }

  getMusicSettings() async {
    playMusic();
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getMusicSettings();
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call on Duty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DashboardPage(),
    );
  }
}
