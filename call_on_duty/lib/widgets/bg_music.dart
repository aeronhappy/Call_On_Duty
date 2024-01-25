import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

var audioP = AudioPlayer();
var bgAudioPlayer = AudioCache(fixedPlayer: audioP);
var effectsAudioPlayer = AudioCache();
////ok to
FlutterTts flutterTts = FlutterTts();

List<String> bgList = <String>[
  'bg_music/bg_1.mp3',
];

textToSpeech(String text) async {
  playMusicLowVolume();
  await flutterTts.setVoice({"name": "fil-ph-x-fie-local", "locale": "fil-PH"});
  await flutterTts.setSpeechRate(.5);
  await flutterTts.setPitch(.7);
  await flutterTts.speak(text);
  await flutterTts.awaitSpeakCompletion(true).whenComplete(() {
    playMusic();
  });
}

speechStop() async {
  await flutterTts.stop();
}

playMusic() async {
  var sharedPref = await SharedPreferences.getInstance();
  bool isMusicOn = sharedPref.getBool('isMusicOn') ?? true;

  if (isMusicOn) {
    bgAudioPlayer.loop('bg_music/bg_1.mp3', volume: .2);
  }
}

playMusicLowVolume() async {
  var sharedPref = await SharedPreferences.getInstance();
  bool isMusicOn = sharedPref.getBool('isMusicOn') ?? true;
  if (isMusicOn) {
    bgAudioPlayer.loop('bg_music/bg_1.mp3', volume: .05);
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
        volume: .3);
  }
}
