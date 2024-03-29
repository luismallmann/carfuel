import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/models/abastecer.dart';
import 'package:carfuel/models/calculos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExibirAbastecimentos extends StatefulWidget {
  final int idCarro;
  const ExibirAbastecimentos({Key key, this.idCarro}): super(key: key);

  @override
  _ExibirAbastecimentosState createState() => _ExibirAbastecimentosState();
}

class _ExibirAbastecimentosState extends State<ExibirAbastecimentos> {
  var base = DatabaseHelper();
  List<Abastecer> _listaAbastecidas;

  Future<String> _buscarAbastecidas() async {
    var buscar = await base.listarAbastecimentoCarro(widget.idCarro);

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
    final estiloPrincipal = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey[600]
    );
    final estiloConteudo = TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.blueGrey[400],
    );
    return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blueGrey[800],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('  Relatório de Abastecimento',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                    IconButton(
                      icon: Icon(Icons.exit_to_app, color: Colors.blueGrey[100],),
                      iconSize: 36,
                      onPressed: () {
                        Navigator.of(context).pop();},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DataTable(
                columnSpacing: 0,
                dividerThickness: 1,
                columns:[
                  DataColumn(
                      label: Text('Data', style: estiloPrincipal)),
                  DataColumn(
                      label: Text('km\nAtual',style: estiloPrincipal)),
                  DataColumn(
                      label: Text('Qnt\n(L)',style: estiloPrincipal)),
                  DataColumn(
                      label: Text('Valor\nLitro (R\$)',style: estiloPrincipal,textAlign: TextAlign.center,)),
                  DataColumn(
                      label: Text('Valor\nTotal (R\$)',style: estiloPrincipal,textAlign: TextAlign.center,))
                ],
                rows: _listaAbastecidas.map((e) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(e.dataAbastecimento, style: estiloConteudo,)),
                      DataCell(Text(e.kmAtual.toString(), style: estiloConteudo,)),
                      DataCell(Text(e.quantidade.toString(), style: estiloConteudo,)),
                      DataCell(Text(e.valor.toString(), style: estiloConteudo,)),
                      DataCell(Text((e.valor*e.quantidade).toString(), style: estiloConteudo,)),
                    ]
                ),
                ).toList(),
              )
            ],
          ),
        );
/*
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
            ],
          )
        ],
      ),
    );

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
    ); */
  }
}