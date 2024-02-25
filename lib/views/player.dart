import 'package:flutter/material.dart';
import 'package:musicapp_flutter/consts/text_style.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              alignment: Alignment.center,
              child: Icon(Icons.music_note),
            )),
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
                    'Music name',
                    style: songTitleTextStyle(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Artist name',
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
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
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
