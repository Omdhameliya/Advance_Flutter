
import 'package:flutter/material.dart';
import 'package:geeta/models/chapter_model.dart';

class ShlokDetailPage extends StatefulWidget {
  const ShlokDetailPage({Key? key}) : super(key: key);

  @override
  State<ShlokDetailPage> createState() => _ShlokDetailPageState();
}

class _ShlokDetailPageState extends State<ShlokDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(allShloks[shlokIndex].verse),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                allShloks[shlokIndex].sanskrit,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "English",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                allShloks[shlokIndex].english,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Hindi",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                allShloks[shlokIndex].hindi,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Gujarati",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(allShloks[shlokIndex].gujarati),
            ],
          ),
        ),
      ),
    );
  }
}
