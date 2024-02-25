import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp_flutter/consts/text_style.dart';
import 'package:musicapp_flutter/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final SongModel data;

  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: data.id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                    ))),
            const SizedBox(height: 10),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(18),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  color: Color.fromARGB(255, 49, 36, 36)),
              child: Column(
                children: [
                  Text(
                    data.displayNameWOExt,
                    style: songTitleTextStyle(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data.artist.toString(),
                    style: songTitleTextStyle(),
                  ),
                  const SizedBox(height: 10),
                  // Slider-------------------------------------------------
                  Row(
                    children: [
                      Text('0:00', style: songTitleTextStyle()),
                      Expanded(
                          child: Slider(value: 0.0, onChanged: (newValue) {})),
                      Text('2:56', style: songTitleTextStyle()),
                    ],
                  ),

                  const SizedBox(height: 10),
                  // controls-----------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      Obx(
                        () => CircleAvatar(
                          radius: 35,
                          backgroundColor:
                              const Color.fromARGB(255, 49, 36, 36),
                          child: IconButton(
                              onPressed: () {
                                if (controller.isPlaying.value) {
                                  controller.audioPlayer.pause();
                                  controller.isPlaying(false);
                                } else {
                                  controller.audioPlayer.play();
                                  controller.isPlaying(true);
                                }
                              },
                              icon: controller.isPlaying.value
                                  ? const Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                      size: 36,
                                    )
                                  : const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 36,
                                    )),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
