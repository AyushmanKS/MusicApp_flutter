import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPlaying = false.obs;
  var duration = ''.obs;
  var position = ''.obs;

  // making sure usrs has given permission
  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  // update the position
  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split('.')[0];
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split('.')[0];
    });
  }

  // playsong function
  playSong(String? uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkPermission() async {
    var perm = await Permission.audio.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }
}
