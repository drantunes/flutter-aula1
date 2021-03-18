import 'package:flutter/material.dart';
import 'package:flutter_aula1/pages/time_page.dart';
import 'package:flutter_aula1/repositories/times_repository.dart';
import 'package:flutter_aula1/widgets/brasao.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../models/time.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brasileirão'),
      ),
      body: Consumer<TimesRepository>(builder: (context, repositorio, child) {
        return ListView.separated(
          itemCount: repositorio.times.length,
          itemBuilder: (BuildContext contexto, int time) {
            final List<Time> tabela = repositorio.times;
            return ListTile(
              leading: Brasao(
                image: tabela[time].brasao,
                width: 40,
              ),
              title: Text(tabela[time].nome),
              subtitle: Text('Titulos: ${tabela[time].titulos.length}'),
              trailing: Text(
                tabela[time].pontos.toString(),
              ),
              onTap: () {
                Get.to(() => TimePage(
                      key: Key(tabela[time].nome),
                      time: tabela[time],
                    ));
              },
            );
          },
          separatorBuilder: (_, __) => Divider(),
          padding: EdgeInsets.all(16),
        );
      }),
    );
  }
}
