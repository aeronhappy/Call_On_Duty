import 'package:audioplayers/audioplayers.dart';

var audioP = AudioPlayer();
var bgAudioPlayer = AudioCache(fixedPlayer: audioP);
var effectsAudioPlayer = AudioCache();

List<String> bgList = <String>[
  'bg_music/bg_1.mp3',
];

playMusic() {
  bgAudioPlayer.loop('bg_music/bg_1.mp3');
}

playMusicLowVolume() {
  bgAudioPlayer.loop('bg_music/bg_1.mp3', volume: .2);
}

stopMusic() {
  audioP.stop();
}
