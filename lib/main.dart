import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'controllers/providers/connectivity_provider.dart';
import 'views/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConnectivityProvier()),
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const Homepage(),
          },
        );
      },
    ),
  );
}
