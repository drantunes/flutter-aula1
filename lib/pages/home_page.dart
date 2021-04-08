import 'package:flutter/material.dart';
import 'package:flutter_aula1/controllers/theme_controller.dart';
import 'package:flutter_aula1/pages/time_page.dart';
import 'package:flutter_aula1/repositories/times_repository.dart';
import 'package:flutter_aula1/services/auth_service.dart';
import 'package:flutter_aula1/widgets/brasao.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../models/time.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = ThemeController.to;

  showEscolherTime() {
    Get.back();

    final times = Provider.of<TimesRepository>(context, listen: false).times;
    List<SimpleDialogOption> items = [];

    times.forEach((time) {
      items.add(
        SimpleDialogOption(
          child: Row(
            children: [
              Brasao(
                image: time.brasao,
                width: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(time.nome),
              ),
            ],
          ),
          onPressed: () {
            Get.find<AuthService>().definirTime(time);
            Get.back();
          },
        ),
      );
    });

    final SimpleDialog dialog = SimpleDialog(
      title: Text('Escolha sua torcida'),
      children: items,
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 6),
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Consumer<TimesRepository>(builder: (context, repositorio, child) {
          return repositorio.loading.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    Text('Atualizando'),
                  ],
                )
              : Text('Tabela Brasileirão');
        }),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Obx(() => controller.isDark.value
                      ? Icon(Icons.brightness_7)
                      : Icon(Icons.brightness_2)),
                  title: Obx(() =>
                      controller.isDark.value ? Text('Light') : Text('Dark')),
                  onTap: () => controller.changeTheme(),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text('Escolher Torcida'),
                  onTap: () => showEscolherTime(),
                ),
              ),
              PopupMenuItem(
                  child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: () {
                  Navigator.pop(context);
                  AuthService.to.logout();
                },
              )),
            ],
          ),
        ],
      ),
      body: Consumer<TimesRepository>(builder: (context, repositorio, child) {
        return RefreshIndicator(
          child: ListView.separated(
            itemCount: repositorio.times.length,
            itemBuilder: (BuildContext contexto, int time) {
              print(repositorio.times.length);
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
          ),
          onRefresh: () => repositorio.updateTabela(),
        );
      }),
    );
  }
}
