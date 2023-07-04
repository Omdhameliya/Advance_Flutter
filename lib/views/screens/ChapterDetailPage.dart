import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeta/models/all_chapters_model.dart';
import 'package:geeta/models/chapter_model.dart';

class ChapterDetailPage extends StatefulWidget {
  const ChapterDetailPage({Key? key}) : super(key: key);

  @override
  State<ChapterDetailPage> createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  String? data;

  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  Future<void> loadJSON() async {
    data = await rootBundle.loadString(allChapters[chapterIndex].jsonPath);

    List decodedList = jsonDecode(data!);
    setState(() {});

    allShloks = decodedList
        .map(
          (e) => ChapterModel.fromMap(data: e),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(allChapters[chapterIndex].nameTranslationEnglish),
      ),
      body: ListView.builder(
        itemCount: allShloks.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            shlokIndex = index;
            Navigator.of(context).pushNamed("shlok_detail_page");
          },
          leading: Text(
            allShloks[index].verse,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          title: Text(allShloks[index].sanskrit),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
