import 'package:flutter/material.dart';
import 'package:flutter_aula1/services/auth_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../pages/home_page.dart';
import '../pages/autenticacao_page.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthService.to.userIsAuthenticated.value
        ? HomePage()
        : AutenticacaoPage());
  }
}
