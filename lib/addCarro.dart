import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/home.dart';
import 'package:carfuel/models/carro.dart';
import 'package:carfuel/models/usuario.dart';
import 'package:flutter/material.dart';

class CadastrarCarro extends StatefulWidget {
  final User user;
  const CadastrarCarro({Key key, this.user}): super(key: key);
  @override
  _CadastrarCarroState createState() => _CadastrarCarroState();
}

class _CadastrarCarroState extends State<CadastrarCarro> {
  var base = DatabaseHelper();
  String _modelo;
  String _fabricante;
  String _placa;
  String _ano;
  String _kmInicial;
  int _FK_idUsuario;

  final dadosCarro = new GlobalKey<FormState>();

  void _adicionarCarro() async{
    final dadosAtuais = dadosCarro.currentState;

    if(dadosAtuais.validate()){
      dadosAtuais.save();

      Carro carro = Carro(null, _modelo, _fabricante, _placa, int.parse(_ano), double.parse(_kmInicial), 0);

      carro.idCarro = await base.saveCarro(carro);

      if(carro.idCarro != null && carro.idCarro>0){
        Navigator.pop(context, true); //sai da janela
      }else{
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text("Erro de Registro"),
                  content: Text("Erro ao tentar registrar o usuário!"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))));
            });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    //salva a id do usuario vinculado ao veiculo
    _FK_idUsuario = widget.user.idUsuario;
    return Form(
        key: dadosCarro,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Cadastrar Carro",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      TextFormField(
                        onSaved: (valor) => _modelo = valor,
                        decoration: InputDecoration(
                            labelText: "Modelo",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      TextFormField(
                        onSaved: (valor) => _fabricante = valor,
                        decoration: InputDecoration(
                            labelText: "Fabricante",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      TextFormField(
                        onSaved: (valor) => _placa = valor,
                        decoration: InputDecoration(
                            labelText: "Placa",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      TextFormField(
                        onSaved: (valor) => _ano = valor,
                        decoration: InputDecoration(
                            labelText: "Ano de Fabricação",
                            hasFloatingPlaceholder: true
                        ),
                          keyboardType: TextInputType.datetime
                      ),
                      TextFormField(
                        onSaved: (valor) => _kmInicial = valor,
                        decoration: InputDecoration(
                            labelText: "Quilometragem Inicial",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      FlatButton(
                        color: Colors.green,
                        child: Text('Cadastrar'),
                        onPressed: _adicionarCarro,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
