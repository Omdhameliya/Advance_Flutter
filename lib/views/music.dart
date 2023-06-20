import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../music_utils.dart';
import 'Musicpage.dart';
import 'package:carousel_slider/carousel_controller.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
        child: Column(
              children: [
                Column(
                  children:MyMusicList.map((e) => Card(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      elevation: 3,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      borderOnForeground: false,
                      child: ListTile(
                        tileColor: Colors.purple.shade100,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(e['Image'],
                          ),),
                        title: Text(e['Mname']),
                        subtitle: Text(e["AName"]),
                        trailing: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Musicpage(
                                    AName: e['AName'],
                                    Image: e['Image'],
                                    Music: e['Music'],
                                    Name: e['Mname'],
                                  )));
                            },
                            child: Icon(Icons.play_arrow)),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),
                    ),
                ).toList(),
              ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade900,
    );
  }
}
