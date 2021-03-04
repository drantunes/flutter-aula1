import 'package:flutter/material.dart';

import 'titulo.dart';

class Time {
  String nome;
  String brasao;
  int pontos;
  Color cor;
  List<Titulo> titulos = [];

  Time({this.brasao, this.nome, this.pontos, this.cor});
}
