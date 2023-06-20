import 'package:flutter/material.dart';
import '../video_utils.dart';
import 'my_video_page.dart';

void main() {
  runApp(const Video());
}

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: Videolist.map(
                      (e) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Video_page(
                            Name: e['Vname'],
                            video: e['Video'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 200,
                      width: 330,
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                            image: AssetImage(
                              e['VImage'],
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.play_circle_filled,
                        color: Colors.white.withOpacity(0.7),
                        size: 50,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
          ),
          backgroundColor: Colors.grey.shade900,
        );
  }
}
