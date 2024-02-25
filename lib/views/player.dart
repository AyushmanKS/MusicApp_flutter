import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp_flutter/consts/text_style.dart';
import 'package:musicapp_flutter/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;

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
            // Song Image
            Obx(
              () => Expanded(
                  child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      alignment: Alignment.center,
                      child: QueryArtworkWidget(
                        id: data[controller.playIndex.value].id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                      ))),
            ),
            const SizedBox(height: 10),
            // Song Name and Artist name
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(18),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  color: Color.fromARGB(255, 49, 36, 36)),
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: songTitleTextStyle(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: songTitleTextStyle(),
                    ),
                    const SizedBox(height: 10),
                    // Slider-------------------------------------------------
                    Obx(
                      () => Row(
                        children: [
                          Text(controller.position.value,
                              style: songTitleTextStyle()),
                          Expanded(
                              child: Slider(
                                  min: const Duration(seconds: 0)
                                      .inSeconds
                                      .toDouble(),
                                  max: controller.max.value,
                                  value: controller.value.value,
                                  onChanged: (newValue) {
                                    controller.changeDurationToSeconds(
                                        newValue.toInt());
                                    newValue = newValue;
                                  })),
                          Text(controller.duration.value,
                              style: songTitleTextStyle()),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    // controls-----------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // SkipPrev
                        IconButton(
                          onPressed: () {
                            if (controller.playIndex.value > 0) {
                              controller.playSong(
                                  data[controller.playIndex.value - 1].uri,
                                  controller.playIndex.value - 1);
                            } else {
                              // Optional: Handle what to do when trying to go back from the first song.
                            }
                          },
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        // Pause/Play
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
                        // SkipNext
                        IconButton(
                          onPressed: () {
                            if (controller.playIndex.value < data.length - 1) {
                              controller.playSong(
                                  data[controller.playIndex.value + 1].uri,
                                  controller.playIndex.value + 1);
                            } else {
                              // Optional: Handle what to do when trying to go forward from the last song.
                            }
                          },
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
              ),
            ))
          ],
        ),
      ),
    );
  }
}
