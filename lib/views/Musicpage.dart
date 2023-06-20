import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../music_utils.dart';

class Musicpage extends StatefulWidget {
  String Music;
  String AName;
  String Name;
  String Image;

  Musicpage({Key? key,
    required this.Image,
    required this.Name,
    required this.AName,
    required this.Music
  }) : super(key: key);

  @override
  State<Musicpage> createState() => _MusicpageState();
}

class _MusicpageState extends State<Musicpage> {
  AssetsAudioPlayer MyAudio = AssetsAudioPlayer();
  Duration? totalDuration;
  AnimationController? MyIconcontroller;
  SliderComponentShape? mythumb = SliderComponentShape.noThumb;

  @override
  void initState() {
    super.initState();
    MyAudio.open(
      Playlist(
        audios: MyMusicList.map((e) => Audio(
          widget.Music,
        )).toList(),
      ),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    MyAudio.dispose();
  }

  bool play = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.Name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(widget.Image,
              ),),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.Name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            Text(
              widget.AName,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () async {
                      await MyAudio.stop();
                    },
                    icon: Icon(Icons.stop)
                ),
                IconButton(
                    onPressed: () async {
                      await MyAudio.seekBy(Duration(seconds: -10));
                      },
                    icon: Icon(Icons.fast_rewind)),
                StreamBuilder(
                  stream: MyAudio.isPlaying,
                  builder: (context, snapshot) {
                    var val = snapshot.data;

                    return IconButton(
                        onPressed: () {
                          (val == true)
                            ? MyAudio.pause() 
                            : MyAudio.play();

                        },
                        icon: (val == true)
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                    );
                  },
                ),
                IconButton(
                    onPressed: () async {
                      await MyAudio.seekBy(Duration(seconds: 10));
                    },
                    icon: Icon(Icons.fast_forward),
                ),
                IconButton(
                    onPressed: () {
                      if (play == true) {
                        MyAudio.setVolume(00);
                        setState(() {
                          play = !play;
                        });
                      } else {
                        MyAudio.setVolume(100);
                        setState(() {
                          play = !play;
                        });
                      }
                    },
                    icon: play
                        ? const Icon(
                      Icons.volume_up,
                    )
                        : const Icon(
                      Icons.volume_off,
                    )),
              ],
            ),
            StreamBuilder(
                stream: MyAudio.currentPosition,
                builder: (BuildContext context,AsyncSnapshot snapshot) {
                    Duration data = snapshot.data??Duration(seconds: 0);
                    try {
                      totalDuration = MyAudio.current.value?.audio.duration;
                    } catch (e) {
                      totalDuration = Duration(seconds: 0);
                    }
                    return Column(
                      children: [
                        Slider(
                          min: 0,
                          max: totalDuration!.inSeconds.toDouble(),
                          value: data.inSeconds.toDouble(),
                          onChanged: (val){
                            MyAudio.seek(Duration(seconds: val.toInt()));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${data.toString().split(".")[0]}",
                                style: TextStyle(fontSize: 16,
                                color: Colors.purple.shade100,
                                ),
                              ),
                              Text("${totalDuration.toString().split(".")[0]}",
                                style: TextStyle(fontSize: 16,
                                  color: Colors.purple.shade100,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                }
            ),

          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
