import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/models/abastecer.dart';
import 'package:flutter/material.dart';

class ExibirAbastecimentos extends StatefulWidget {
  @override
  _ExibirAbastecimentosState createState() => _ExibirAbastecimentosState();
}

class _ExibirAbastecimentosState extends State<ExibirAbastecimentos> {
  var base = DatabaseHelper();
  List<Abastecer> _listaAbastecidas;

  Future<String> _buscarAbastecidas() async {
    var buscar = await base.listarAbastecimento();

    setState(() {
      _listaAbastecidas = buscar;
    });
    return 'ok';
  }

  @override
  void initState() {
    super.initState();
    this._buscarAbastecidas();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _listaAbastecidas.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
              child: Column(
                children: <Widget>[
              Card(
              color: Colors.green,
                child: Container(
                  height: 200,
                ),
              )
                ],
              )
          );
        }
    );
  }
}