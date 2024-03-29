import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/models/usuario.dart';
import 'package:flutter/material.dart';

class CadastrarUsuario extends StatefulWidget {
  @override
  _CadastrarUsuarioState createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {
  var base = DatabaseHelper();
  String _nome = "";
  String _email = "";
  String _senha = "";
  bool senhaVisivel = true;

  final dadosCadastro = new GlobalKey<FormState>();

  void _adicionarUsuario() async{
    final dadosAtuais = dadosCadastro.currentState;

    if(dadosAtuais.validate()){
      dadosAtuais.save();

      User usuario = User(null, _nome, _email, _senha);

      usuario.idUsuario = await base.saveUser(usuario);

      if(usuario.idUsuario != null && usuario.idUsuario>0){
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
    return Form(
      key: dadosCadastro,
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
                          "Cadastrar Usuário",
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
                        onSaved: (valor) => _nome = valor.trim(),
                        decoration: InputDecoration(
                            labelText: "Nome",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      TextFormField(
                        onSaved: (valor) => _email = valor.trim(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      TextFormField(
                        onSaved: (valor) => _senha = valor.trim(),
                        obscureText: senhaVisivel,
                        decoration: InputDecoration(
                            labelText: "Senha",
                            hasFloatingPlaceholder: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                                senhaVisivel ? Icons.visibility : Icons.visibility_off
                            ),
                            onPressed: (){
                              setState(() {
                                senhaVisivel ? senhaVisivel = false : senhaVisivel = true;
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        "A senha deve conter no mínimo 6 caracteres",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonTheme(
                  minWidth: 160,
                  height: 35,
                  child: RaisedButton.icon(
                    onPressed: _adicionarUsuario,
                    textColor: Colors.white,
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    icon: Icon(Icons.add_circle_outline, size: 25,),
                    label: Text('Cadastrar', style: TextStyle(fontSize: 18)),
                  ),
                      ),
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
