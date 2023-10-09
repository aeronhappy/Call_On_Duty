import 'package:call_on_duty/views/dashboard_page.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
import 'package:flutter/material.dart';
import 'package:call_on_duty/helper/api_helper.dart' as api_helper;
import 'package:call_on_duty/repository/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  api_helper.initializeClient(token: '');
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
  bool isMusicOn = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    var sharedPref = await SharedPreferences.getInstance();
    setState(() {
      isMusicOn = sharedPref.getBool('isMusicOn') ?? true;
    });

    if (state == AppLifecycleState.paused) {
      if (isMusicOn) {
        stopMusic();
      }
    }

    if (state == AppLifecycleState.resumed) {
      if (isMusicOn) {
        playMusic();
      }
    }
  }

  getMusicSettings() async {
    var sharedPref = await SharedPreferences.getInstance();
    setState(() {
      isMusicOn = sharedPref.getBool('isMusicOn') ?? true;
    });
    if (isMusicOn) {
      playMusic();
    }
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
      home: const DashboardPage(),
    );
  }
}
