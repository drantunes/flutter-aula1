import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula1/database/db.dart';
import 'package:flutter_aula1/database/db_firestore.dart';
import '../models/time.dart';
import '../models/titulo.dart';

class TimesRepository extends ChangeNotifier {
  final List<Time> _times = [];

  UnmodifiableListView<Time> get times => UnmodifiableListView(_times);

  void addTitulo({Time time, Titulo titulo}) async {
    // var db = await DB.get();
    // int id = await db.insert('titulos', {
    //   'campeonato': titulo.campeonato,
    //   'ano': titulo.ano,
    //   'time_id': time.id
    // });
    // titulo.id = id;

    FirebaseFirestore db = await DBFirestore.get();
    var docRef = await db.collection('titulos').add({
      'campeonato': titulo.campeonato,
      'ano': titulo.ano,
      'time_id': time.id
    });
    titulo.id = docRef.id;

    time.titulos.add(titulo);
    notifyListeners();
  }

  void editTitulo({Titulo titulo, String ano, String campeonato}) async {
    // var db = await DB.get();
    // await db.update(
    //   'titulos',
    //   {'campeonato': campeonato, 'ano': ano},
    //   where: 'id = ?',
    //   whereArgs: [titulo.id],
    // );

    FirebaseFirestore db = await DBFirestore.get();
    await db.collection('titulos').doc(titulo.id).update({
      'campeonato': campeonato,
      'ano': ano,
    });

    titulo.campeonato = campeonato;
    titulo.ano = ano;
    notifyListeners();
  }

  static setupTimes() {
    return [
      Time(
        nome: 'Flamengo',
        pontos: 71,
        brasao: 'https://logodetimes.com/times/flamengo/logo-flamengo-256.png',
        cor: Colors.red[900],
      ),
      Time(
        nome: 'Internacional',
        pontos: 69,
        brasao:
            'https://logodetimes.com/times/internacional/logo-internacional-256.png',
        cor: Colors.red[900],
      ),
      Time(
        nome: 'Atlético-MG',
        pontos: 65,
        brasao:
            'https://logodetimes.com/times/atletico-mineiro/logo-atletico-mineiro-256.png',
        cor: Colors.grey[800],
      ),
      Time(
        nome: 'São Paulo',
        pontos: 63,
        brasao:
            'https://logodetimes.com/times/sao-paulo/logo-sao-paulo-256.png',
        cor: Colors.red[900],
      ),
      Time(
        nome: 'Fluminense',
        pontos: 61,
        brasao:
            'https://logodetimes.com/times/fluminense/logo-fluminense-256.png',
        cor: Colors.teal[800],
      ),
      Time(
        nome: 'Grêmio',
        pontos: 59,
        brasao: 'https://logodetimes.com/times/gremio/logo-gremio-256.png',
        cor: Colors.blue[900],
      ),
      Time(
        nome: 'Palmeiras',
        pontos: 58,
        brasao:
            'https://logodetimes.com/times/palmeiras/logo-palmeiras-256.png',
        cor: Colors.green[800],
      ),
      Time(
        nome: 'Santos',
        pontos: 54,
        brasao: 'https://logodetimes.com/times/santos/logo-santos-256.png',
        cor: Colors.grey[800],
      ),
      Time(
        nome: 'Athletico-PR',
        pontos: 50,
        brasao:
            'https://logodetimes.com/times/atletico-paranaense/logo-atletico-paranaense-256.png',
        cor: Colors.red[900],
      ),
      Time(
        nome: 'Corinthians',
        pontos: 50,
        brasao:
            'https://logodetimes.com/times/corinthians/logo-corinthians-256.png',
        cor: Colors.grey[800],
      ),
      Time(
        nome: 'Bragantino',
        pontos: 50,
        brasao:
            'https://logodetimes.com/times/red-bull-bragantino/logo-red-bull-bragantino-256.png',
        cor: Colors.grey[800],
      ),
      Time(
        nome: 'Ceará',
        pontos: 49,
        brasao: 'https://logodetimes.com/times/ceara/logo-ceara-256.png',
        cor: Colors.grey[800],
      ),
      Time(
        nome: 'Atlético-GO',
        pontos: 47,
        brasao:
            'https://logodetimes.com/times/atletico-goianiense/logo-atletico-goianiense-256.png',
        cor: Colors.red[900],
      ),
      Time(
        nome: 'Sport',
        pontos: 42,
        brasao:
            'https://logodetimes.com/times/sport-recife/logo-sport-recife-256.png',
        cor: Colors.red[900],
      ),
      Time(
        nome: 'Bahia',
        pontos: 41,
        brasao: 'https://logodetimes.com/times/bahia/logo-bahia-256.png',
        cor: Colors.blue[900],
      ),
      Time(
        nome: 'Fortaleza',
        pontos: 41,
        brasao:
            'https://logodetimes.com/times/fortaleza/logo-fortaleza-256.png',
        cor: Colors.red[900],
      ),
      Time(
        nome: 'Vasco',
        pontos: 38,
        brasao:
            'https://logodetimes.com/times/vasco-da-gama/logo-vasco-da-gama-256.png',
        cor: Colors.grey[800],
      ),
      Time(
        nome: 'Goiás',
        pontos: 37,
        brasao: 'https://logodetimes.com/times/goias/logo-goias-novo-256.png',
        cor: Colors.green[900],
      ),
      Time(
        nome: 'Coritiba',
        pontos: 31,
        brasao: 'https://logodetimes.com/times/coritiba/logo-coritiba-5.png',
        cor: Colors.green[900],
      ),
      Time(
        nome: 'Botafogo',
        pontos: 27,
        brasao: 'https://logodetimes.com/times/botafogo/logo-botafogo-256.png',
        cor: Colors.grey[800],
      ),
    ];
  }

  TimesRepository() {
    initRepository();
  }

  initRepository() async {
    var db = await DB.get(); // explicar que aqui irá iniciar o DB

    List ts = await db.query('times');
    //Equivalente a db.rawQuery('SELECT * FROM times');

    for (var t in ts) {
      var time = Time(
          id: t['id'],
          nome: t['nome'],
          brasao: t['brasao'],
          pontos: t['pontos'],
          cor: Color(int.parse(t['cor'])),
          titulos: await getTitulos(t['id']));
      _times.add(time);
    }
    notifyListeners();
  }

  getTitulos(timeId) async {
    // var db = await DB.get();
    // var results =
    //     await db.query('titulos', where: 'time_id = ?', whereArgs: [timeId]);
    // List<Titulo> titulos = [];
    // for (var titulo in results) {
    //   titulos.add(Titulo(
    //     id: titulo['id'],
    //     campeonato: titulo['campeonato'],
    //     ano: titulo['ano'],
    //   ));
    // }

    FirebaseFirestore db = await DBFirestore.get();
    var snapshot = await db
        .collection('titulos')
        .where('time_id', isEqualTo: timeId)
        .get();
    List<Titulo> titulos = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data();
      titulos.add(Titulo(
        id: doc.id,
        campeonato: data['campeonato'],
        ano: data['ano'],
      ));
    });

    return titulos;
  }
}
