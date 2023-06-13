import 'dart:io';

import 'package:converter_app/controllers/providers/add_chat_provider.dart';
import 'package:converter_app/controllers/providers/app_provider.dart';
import 'package:converter_app/controllers/providers/profile_provider.dart';
import 'package:converter_app/controllers/providers/theme_provider.dart';
import 'package:converter_app/models/add_chat_model.dart';
import 'package:converter_app/models/app_model.dart';
import 'package:converter_app/models/profile_model.dart';
import 'package:converter_app/models/theme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/screens/cupertino_design//HomePage.dart' as ios;
import 'views/screens/material_design/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool appSwitch = prefs.getBool('appSwitch') ?? false;
  bool appTheme = prefs.getBool('AppTheme') ?? false;
  bool profileSwitch = prefs.getBool('profileSwitch') ?? false;

  String userImage = prefs.getString('userImage') ?? '';
  String userName = prefs.getString('userName') ?? '';
  String userBio = prefs.getString('userBio') ?? '';

  List<String> image = prefs.getStringList('image') ?? [];
  List<String> fullName = prefs.getStringList('fullName') ?? [];
  List<String> phoneNumber = prefs.getStringList('phoneNumber') ?? [];
  List<String> chatConversation = prefs.getStringList('chatConversation') ?? [];
  List<String> date = prefs.getStringList('date') ?? [];
  List<String> time = prefs.getStringList('time') ?? [];

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(
            appModel: AppModel(
              isIos: appSwitch,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(
              isDark: appTheme,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(
            profileModel: ProfileModel(
              profileSwitch: profileSwitch,
              userImage: File(userImage),
              userName: TextEditingController(text: userName),
              userBio: TextEditingController(text: userBio),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AddChatProvider(
            addChatModel: AddChatModel(
              fullName: fullName,
              phoneNumber: phoneNumber,
              chatConversation: chatConversation,
              image: image,
              date: date,
              time: time,
            ),
          ),
        ),
      ],
      builder: (context, _) {
        return (Provider.of<AppProvider>(context).appModel.isIos == false)
            ? MaterialApp(
                darkTheme: ThemeData.dark(
                  useMaterial3: true,
                ),
                theme: ThemeData.light(
                  useMaterial3: true,
                ),
                themeMode:
                    (Provider.of<ThemeProvider>(context).themeModel.isDark)
                        ? ThemeMode.dark
                        : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                routes: {
                  '/': (context) => const HomePage(),
                },
              )
            : CupertinoApp(
                theme: CupertinoThemeData(
                  brightness:
                      (Provider.of<ThemeProvider>(context).themeModel.isDark)
                          ? Brightness.dark
                          : Brightness.light,
                ),
                debugShowCheckedModeBanner: false,
                routes: {
                  '/': (context) => const ios.HomePage(),
                },
              );
      },
    ),
  );
}
