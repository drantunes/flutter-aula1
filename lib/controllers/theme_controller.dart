import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;
  Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };
  // SharedPreferences prefs;

  static ThemeController get to => Get.find();

  loadThemeMode() async {
    // prefs = await SharedPreferences.getInstance();
    // String themeText = prefs.getString('theme') ?? 'light';
    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('preferencias', path: dir.path);
    String themeText = box.get('theme') ?? 'light';
    isDark.value = themeText == 'dark' ? true : false;
    setMode(themeText);
  }

  Future setMode(String themeText) async {
    ThemeMode themeMode = themeModes[themeText];
    Get.changeThemeMode(themeMode);
    var box = await Hive.openBox('preferencias');
    await box.put('theme', themeText);
    // prefs = await SharedPreferences.getInstance();
    // await prefs.setString('theme', themeText);
  }

  changeTheme() {
    setMode(isDark.value ? 'light' : 'dark');
    isDark.value = !isDark.value;
  }
}
