import 'package:flutter/material.dart';
import '../models/time.dart';
import '../models/titulo.dart';
import './add_titulo_page.dart';

class TimePage extends StatefulWidget {
  Time time;
  TimePage({Key key, this.time}) : super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  tituloPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddTituloPage(time: widget.time, onSave: this.addTitulo),
      ),
    );
  }

  addTitulo(Titulo titulo) {
    setState(() {
      widget.time.titulos.add(titulo);
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Salvo com sucesso!')));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.time.cor,
          title: Text(widget.time.nome),
          actions: [IconButton(icon: Icon(Icons.add), onPressed: tituloPage)],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.stacked_line_chart),
                text: 'Estatísticas',
              ),
              Tab(
                icon: Icon(Icons.emoji_events),
                text: 'Títulos',
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(24),
                child: Image.network(
                    widget.time.brasao.replaceAll("40x40", "100x100")),
              ),
              Text(
                'Pontos: ${widget.time.pontos}',
                style: TextStyle(fontSize: 22),
              )
            ],
          ),
          titulos()
        ]),
      ),
    );
  }

  Widget titulos() {
    final quantidade = widget.time.titulos.length;

    return quantidade == 0
        ? Container(
            child: Center(
              child: Text('Nenhum Titulo Ainda!'),
            ),
          )
        : ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.emoji_events),
                title: Text(widget.time.titulos[index].campeonato),
                trailing: Text(widget.time.titulos[index].ano),
              );
            },
            separatorBuilder: (_, __) => Divider(),
            itemCount: quantidade,
          );
  }
}
