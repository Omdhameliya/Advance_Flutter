import 'package:flutter/material.dart';
import 'package:geeta/controllers/providers/theme_provider.dart';
import 'package:geeta/models/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/screens/ChapterDetailPage.dart';
import 'views/screens/HomePage.dart';
import 'views/screens/ShlokDetailPage.dart';
import 'views/screens/SplashScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isDark = prefs.getBool('appTheme') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(
              isDark: isDark,
            ),
          ),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        darkTheme: ThemeData(useMaterial3: true),
        themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
        routes: {
          '/': (context) => const SplashScreen(),
          'Home_Page': (context) => const HomePage(),
          'chapter_detail_page': (context) => const ChapterDetailPage(),
          'shlok_detail_page': (context) => const ShlokDetailPage(),
        },
      ),
    ),
  );
}
