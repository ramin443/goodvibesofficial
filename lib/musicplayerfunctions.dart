import 'package:assets_audio_player/assets_audio_player.dart';

final assetsAudioPlayer=AssetsAudioPlayer();
bool loop=false;

initializeaudio()async{
  assetsAudioPlayer.open(
    Audio("assets/audio/2 Minute Timer - Calm and Relaxing Music.mp3",
      metas: Metas(
        title:  "Activate your higher mind",
        artist: "Breathing with your body",
        album: "Calm",
        image: MetasImage.asset("assets/images/anxiety.png"), //can be MetasImage.network
      ),

    ),
    loopMode:loop? LoopMode.single:LoopMode.none,
    volume: 80,
    notificationSettings: NotificationSettings(

    ),
    showNotification: true,);
    //   playInBackground: PlayInBackground.enabled,
}
pauseorplay()async{
  assetsAudioPlayer.isPlaying.value?assetsAudioPlayer.pause():assetsAudioPlayer.play();
}