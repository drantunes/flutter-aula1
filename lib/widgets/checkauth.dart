import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/autenticacao_page.dart';

class CheckAuth extends StatelessWidget {
  final bool userIsAuthenticated = false;
  @override
  Widget build(BuildContext context) {
    return userIsAuthenticated ? HomePage() : AutenticacaoPage();
  }
}
