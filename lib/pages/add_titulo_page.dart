import 'package:flutter/material.dart';
import 'package:flutter_aula1/repositories/times_repository.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../models/time.dart';
import '../models/titulo.dart';

class AddTituloPage extends StatefulWidget {
  final Time time;

  AddTituloPage({Key key, this.time}) : super(key: key);

  @override
  _AddTituloPageState createState() => _AddTituloPageState();
}

class _AddTituloPageState extends State<AddTituloPage> {
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  save() {
    Provider.of<TimesRepository>(context, listen: false).addTitulo(
      time: widget.time,
      titulo: Titulo(
        ano: _ano.text,
        campeonato: _campeonato.text,
      ),
    );

    Get.back();

    Get.snackbar(
      'Sucesso!',
      'Titulo cadastrado!',
      backgroundColor: Colors.grey[900],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Titulo'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: TextFormField(
                controller: _ano,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ano',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o ano do titulo!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: TextFormField(
                controller: _campeonato,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Campeonato',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe qual é o campeonato!';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    save();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Salvar', style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
