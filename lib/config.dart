import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_aula1/services/auth_service.dart';
import 'package:get/get.dart';

import 'package:flutter_aula1/controllers/theme_controller.dart';

initConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp();

  // GetX Bindings
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<AuthService>(() => AuthService());
}
