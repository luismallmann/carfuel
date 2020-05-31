import 'package:carfuel/addCarro.dart';
import 'package:carfuel/db/database_helper.dart';
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
  int _index = 0;
  var base = DatabaseHelper();
  List<Carro> _mostrarCarros;
  Widget _getBody(){
    void _exibirCarros() async {
       _mostrarCarros = await base.listarCarros();
    }
    switch(_index) {
      case 0: return Container(
        child:Column(
          children: <Widget>[
            Expanded(
              child: Card(
                child: Text('Média Geral'),
              ),
            ),
            Expanded(
              child: Card(
                child: Text('Custo Geral'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200,
                    child: RaisedButton.icon(
                    onPressed: _exibirCarros,
                  textColor: Colors.white,
                  color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    icon: Icon(Icons.add_circle),
                    label: Text('Abastecimento'),
                )
                ),
                ButtonTheme(
                  minWidth: 200,
                  child: RaisedButton.icon(
                  onPressed: () => showDialog(context: context, builder: (context) => CadastrarCarro(user: widget.user)),
                  textColor: Colors.white,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  icon: Icon(Icons.add_circle),
                  label: Text('Veículo'),
                ),
    )
              ],
            )
          ],
        ),
        color: Colors.amber,
      );
      case 1: _exibirCarros(); return ListView.builder(
            itemCount: _mostrarCarros.length,
            itemBuilder: (
                BuildContext context, int index) {
              return Card(
                  child: Row(
                    children: <Widget>[
                      //foto
                      Expanded(
                          flex: 25,
                          child: Image.asset('assets/img/carro.jpg',
                              height: 50)
                      ),
                      Expanded(
                        flex: 75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text:_mostrarCarros
                                        .elementAt(index)
                                        .fabricante + _mostrarCarros.elementAt(index).modelo,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo,
                                          fontSize: 20,
                                        )
                                    ),
                                    TextSpan(text: '\n'+_mostrarCarros.elementAt(index).placa,
                                        style: TextStyle(color: Colors.indigoAccent,
                                        fontSize: 18))
                                  ]
                              ),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                      )
                    ],
                  )
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
        title: Text('Carfuel'),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index)=>setState((){
          _index = index;
          debugPrint('$_index');
        }),
        backgroundColor: Colors.green,
        unselectedItemColor: Colors.red,
     selectedItemColor: Colors.amber,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')),
          BottomNavigationBarItem(
              icon:Icon(Icons.train),
              title: Text('Veículos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              title: Text('Perfil'))
        ],
      ),
    );
  }
}
