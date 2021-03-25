import 'package:flutter/material.dart';
import 'package:flutter_aula1/services/auth_service.dart';
import 'package:get/get.dart';

class AutenticacaoController extends GetxController {
  final email = TextEditingController();
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var titulo = 'Bem vindo!'.obs;
  var botaoPrincipal = 'Entrar'.obs;
  var appBarButton = 'Cadastre-se'.obs;
  var isLogin = true.obs;
  var isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    ever(isLogin, (visible) {
      titulo.value = visible ? 'Bem vindo' : 'Crie sua conta';
      botaoPrincipal.value = visible ? 'Entrar' : 'Registre-se';
      appBarButton.value = visible ? 'Cadastre-se' : 'Login';
      formKey.currentState.reset();
    });
  }

  login() async {
    isLoading.value = true;
    await AuthService.to.login(email.text, senha.text);
    isLoading.value = false;
  }

  registrar() async {
    isLoading.value = true;
    await AuthService.to.createUser(email.text, senha.text);
    isLoading.value = false;
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }
}
