import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool? isMusicOn = true;
  bool? isSoundEffectsOn = true;
  bool? isVibrationOn = true;

  getSettings() async {
    var sharedPref = await SharedPreferences.getInstance();

    setState(() {
      isMusicOn = sharedPref.getBool('isMusicOn') ?? true;
      isSoundEffectsOn = sharedPref.getBool('isSoundEffectsOn') ?? true;
      isVibrationOn = sharedPref.getBool('isVibrationOn') ?? true;
    });
  }

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20, width: double.infinity),
            Hero(
              tag: 'settings-tag',
              child: Text(
                'SETTINGS',
                textAlign: TextAlign.center,
                style: titleText(30, FontWeight.bold, Colors.white),
              ),
            ),
            const SizedBox(height: 20, width: double.infinity),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Music',
                    style: bodyText(18, FontWeight.w700, Colors.white),
                  ),
                ),
                Checkbox(
                    side: const BorderSide(color: Colors.white),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    fillColor: MaterialStateProperty.all<Color>(Colors.white),
                    checkColor: Colors.red,
                    activeColor: Colors.white,
                    value: isMusicOn,
                    onChanged: (newValue) async {
                      var sharedPref = await SharedPreferences.getInstance();
                      await sharedPref.setBool('isMusicOn', newValue!);
                      setState(() {
                        isMusicOn = newValue;
                      });
                      if (newValue) {
                        playMusic();
                      } else {
                        stopMusic();
                      }
                    })
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sound Effects',
                    style: bodyText(18, FontWeight.w700, Colors.white),
                  ),
                ),
                Checkbox(
                    side: const BorderSide(color: Colors.white),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    fillColor: MaterialStateProperty.all<Color>(Colors.white),
                    checkColor: Colors.red,
                    activeColor: Colors.white,
                    value: isSoundEffectsOn,
                    onChanged: (newValue) async {
                      var sharedPref = await SharedPreferences.getInstance();
                      await sharedPref.setBool('isSoundEffectsOn', newValue!);
                      setState(() {
                        isSoundEffectsOn = newValue;
                      });
                    })
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Vibration',
                    style: bodyText(18, FontWeight.w700, Colors.white),
                  ),
                ),
                Checkbox(
                    side: const BorderSide(color: Colors.white),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    fillColor: MaterialStateProperty.all<Color>(Colors.white),
                    checkColor: Colors.red,
                    activeColor: Colors.white,
                    value: isVibrationOn,
                    onChanged: (newValue) async {
                      var sharedPref = await SharedPreferences.getInstance();
                      await sharedPref.setBool('isVibrationOn', newValue!);
                      setState(() {
                        isVibrationOn = newValue;
                      });
                      if (newValue) {
                        HapticFeedback.vibrate();
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
