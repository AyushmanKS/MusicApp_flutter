import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp_flutter/consts/text_style.dart';
import 'package:musicapp_flutter/controllers/player_controller.dart';
import 'package:musicapp_flutter/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: Colors.black,
      // AppBar-----------------------------------------------------
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: Colors.white,
        ),
        title: Text('Beats', style: appBarTextStyle()),
      ),

      // main body--------------------------------------------------
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              'No song found',
              style: appBarTextStyle(),
            ));
          } else {
            print(snapshot.data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              // listView builder-------------------------------------------
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 44, 37, 37),
                    ),
                    // Listtile----------------------------------------------
                    child: Obx(
                      () => ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        title: Text(snapshot.data![index].displayNameWOExt,
                            style: songTitleTextStyle()),
                        subtitle: Text("${snapshot.data![index].artist}",
                            style: const TextStyle(color: Colors.white)),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: Colors.white,
                          ),
                        ),
                        trailing: controller.playIndex.value == index &&
                                controller.isPlaying.value
                            ? const Icon(Icons.play_arrow, color: Colors.white)
                            : null,
                        onTap: () {
                          Get.to(() => Player(
                                data: snapshot.data!,
                              ));
                          // this stement responsible for playing song
                          controller.playSong(snapshot.data![index].uri, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
