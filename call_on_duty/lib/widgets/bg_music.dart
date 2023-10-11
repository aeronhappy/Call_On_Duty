import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

var audioP = AudioPlayer();
var bgAudioPlayer = AudioCache(fixedPlayer: audioP);
var effectsAudioPlayer = AudioCache();

List<String> bgList = <String>[
  'bg_music/bg_1.mp3',
];

playMusic() async {
  var sharedPref = await SharedPreferences.getInstance();
  bool isMusicOn = sharedPref.getBool('isMusicOn') ?? true;

  if (isMusicOn) {
    bgAudioPlayer.loop('bg_music/bg_1.mp3', volume: .6);
  }
}

playMusicLowVolume() async {
  var sharedPref = await SharedPreferences.getInstance();
  bool isMusicOn = sharedPref.getBool('isMusicOn') ?? true;
  if (isMusicOn) {
    bgAudioPlayer.loop('bg_music/bg_1.mp3', volume: .2);
  }
}

stopMusic() {
  audioP.stop();
}

playEffect(bool isCorrect) async {
  var sharedPref = await SharedPreferences.getInstance();
  bool effects = sharedPref.getBool('isSoundEffectsOn') ?? true;
  bool vibrate = sharedPref.getBool('isVibrationOn') ?? true;

  if (vibrate) {
    HapticFeedback.vibrate();
  }
  if (effects) {
    effectsAudioPlayer.play(
        isCorrect ? 'bg_music/correct_bg.mp3' : 'bg_music/wrong_bg.mp3',
        volume: 1);
  }
}
