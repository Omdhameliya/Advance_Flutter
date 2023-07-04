import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeta/controllers/providers/theme_provider.dart';
import 'package:geeta/models/all_chapters_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? data;

  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  Future<void> loadJSON() async {
    data = await rootBundle.loadString('lib/utils/json/all_chapters.json');

    List decodedList = jsonDecode(data!);
    setState(() {});

    allChapters = decodedList
        .map(
          (e) => AllChapterModel.fromMap(
            data: e,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bhagavad Geeta"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: (Provider.of<ThemeProvider>(context).themeModel.isDark)
                ? const Icon(Icons.mode_night)
                : const Icon(Icons.light_mode_rounded),
          ),
        ],
        backgroundColor: Colors.grey.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: allChapters.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                chapterIndex = i;
                Navigator.of(context).pushNamed("chapter_detail_page");
              },
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/${allChapters[i].imageName}.jpg"),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(allChapters[i].nameHindi),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
