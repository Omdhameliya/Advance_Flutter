import 'package:converter_app/models/app_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  AppModel appModel;

  AppProvider({required this.appModel});

  switchUi() async {
    appModel.isIos = !appModel.isIos;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('appSwitch', appModel.isIos);
    notifyListeners();
  }
}
