import 'package:flutter/material.dart';

import 'titulo.dart';

class Time {
  int id;
  String nome;
  String brasao;
  int pontos;
  Color cor;
  int idAPI;
  List<Titulo> titulos = [];

  Time({
    this.id,
    this.brasao,
    this.nome,
    this.pontos,
    this.cor,
    this.titulos,
    this.idAPI,
  });
}
