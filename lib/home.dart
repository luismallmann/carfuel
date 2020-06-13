import 'package:carfuel/addAbastecimento.dart';
import 'package:carfuel/addCarro.dart';
import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/exibirAbastecimentos.dart';
import 'package:carfuel/models/calculos.dart';
import 'package:carfuel/models/carro.dart';
import 'package:carfuel/models/usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final User user;
  Home({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selecionado=-1;
  int _index = 0;
  var base = DatabaseHelper();
  Calculos calcula = Calculos();
  List<Carro> _mostrarCarros;
  Map<int, String> calculaCusto = new Map();
  Map<int, String> calculaConsumo = new Map();
  String consumoGeral = '0.00';
  String custoGeral = '0.00';

  void _exibirCarros() async {
    _mostrarCarros = await base.listarCarros(widget.user.idUsuario);
  }
  void _calcular (List<Carro> _mostrarCarros, int idUser) async {
    String buscar;
    int idCar;
    for(int i = 0; i < _mostrarCarros.length; i++ ){
      idCar=_mostrarCarros.elementAt(i).idCarro;
      calculaCusto[idCar] =await calcula.gastoVeiculo(idCar);
      calculaConsumo[idCar] =await calcula.mediaVeiculo(idCar);
    }

    custoGeral = await calcula.gastoTotal(idUser);
    consumoGeral = await calcula.mediaTotal(idUser);

  }
  /*
  @override
  void initState() {
    super.initState();
    this._calcular(idCarro);
  }
*/

  Widget _getBody(){
    _exibirCarros();
    _calcular(_mostrarCarros, widget.user.idUsuario);
    switch(_index) {
      case 0:
        return Container(
          color: Colors.blueGrey[200],
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Card(
                        margin: EdgeInsets.all(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                              ),
                              Text('Custo Médio por km\n(R\$/L)',
                              textAlign:TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800]
                              )),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Text(custoGeral,
                                  textAlign:TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              )
                            ],
                          ),
                          height: 250,
                        )
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Card(
                        margin: EdgeInsets.all(40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                              ),
                              Text('Distância Média por Litro\n(km/L)',
                                  textAlign:TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey[800]
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Text(consumoGeral,
                                  textAlign:TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              )
                            ],
                          ),
                          height: 250,
                        )
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    height: 80,
                      minWidth: 250,
                      child: RaisedButton.icon(
                        onPressed: () =>
                            showDialog(context: context,
                                builder: (context) =>
                                    CadastrarAbastecimento(user: widget.user)),
                        textColor: Colors.white,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))
                        ),
                        icon: Icon(Icons.add_circle, size: 60,),
                        label: Text('Abastecimento', style: TextStyle(fontSize: 20)),
                      )
                  ),
                  ButtonTheme(
                    minWidth: 250,
                    height: 80,
                    child: RaisedButton.icon(
                      onPressed: () =>
                          showDialog(context: context,
                              builder: (context) =>
                                  CadastrarCarro(user: widget.user)),
                      textColor: Colors.white,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      icon: Icon(Icons.add_circle, size: 60,),
                      label: Text('Veículo', style: TextStyle(fontSize: 20),),
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        );
      case 1:
        return ListView.builder(
            itemCount: _mostrarCarros.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: Row(
                    children: <Widget>[
                      //foto
                      Expanded(
                          flex: 25,
                          child: Image.asset('assets/img/carro.jpg',
                              height: 120)
                      ),
                      Expanded(
                        flex: 75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                height: 15
                            ),
                            RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: _mostrarCarros.elementAt(index).fabricante
                                        + '/' +
                                        _mostrarCarros.elementAt(index).modelo,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey[800],
                                          fontSize: 22,
                                        )
                                    ),
                                    TextSpan(text: '\n' + _mostrarCarros.elementAt(index).placa,
                                        style: TextStyle(
                                            color: Colors.blueGrey[800],
                                            fontSize: 20))
                                  ]
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                                height: 15
                            ),
                            RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Distância Média por Litro (km/L):',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey[600],
                                          fontSize: 20,
                                        )
                                    ),
                                    TextSpan(text: calculaConsumo[_mostrarCarros.elementAt(index).idCarro],
                                        style: TextStyle(
                                            color: Colors.blueGrey[400],
                                            fontSize: 20))
                                  ]
                              ),
                              textAlign: TextAlign.start,
                            ),
                            RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: 'Custo Médio por km (R\$/km):',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey[600],
                                          fontSize: 20,
                                        )
                                    ),
                                    TextSpan(text: calculaCusto[_mostrarCarros.elementAt(index).idCarro],
                                        style: TextStyle(
                                            color: Colors.blueGrey[400],
                                            fontSize: 20))
                                  ]
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.pageview, color: Colors.grey[400]),
                                  iconSize: 40,
                                  onPressed: () => showDialog(context: context, builder: (context) => ExibirAbastecimentos(idCarro: _mostrarCarros.elementAt(index).idCarro)),
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete, color: Colors.grey[400],),
                                    iconSize: 40,
                                    onPressed: (){
                                      return showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Excluir Veículo'),
                                            content: const Text('Deseja realmente excluir esse veículo e seus registros?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Confirmar'),
                                                onPressed: () {
                                                  base.deleteCarro(index);
                                                  setState(() {
                                                    _getBody();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('Cancelar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );                                    }
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
              );
            }
        );
      case 2: return Container(
        color: Colors.black,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text('Carfuel', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index)=>setState((){
          _index = index;
          debugPrint('$_index');
        }),
        iconSize: 50,
        backgroundColor: Colors.blueGrey[800],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.limeAccent,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home',style: TextStyle(fontSize: 20))),
          BottomNavigationBarItem(
              icon:Icon(Icons.train),
              title: Text('Veículos',style: TextStyle(fontSize: 20))),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              title: Text('Perfil',style: TextStyle(fontSize: 20)))
        ],
      ),
    );
  }
}