import 'dart:async';
import 'package:carfuel/addUsuario.dart';
import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/home.dart';
import 'package:carfuel/models/usuario.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return loginpage();
  }
}

class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool test = true;
  String _email = "";
  String _password = "";
  final formLogin = new GlobalKey<FormState>();
  var base = DatabaseHelper();

  void _validarLogin() async{
    final form = formLogin.currentState;

    if(form.validate()){
      form.save();

      User user = await base.validateLogin(_email, _password);
      print('passa aqui');
      if(user != null){
        print('cheguei');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(user:user)));
      }else {
        setState(() {
        test = false;
      });
      Future.delayed(
          Duration(
            seconds: 3,
          ), () {
        setState(() {
          test = true;
        });
      });
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      onSaved: (valor) => _email = valor,
      validator: (valor){
        return valor.length < 10 ? 'O Campo Usuário deve possuir mais que 10 caracteres' : null;
      },
      decoration: InputDecoration(
        hintText: 'Email',
      ),
    );

    final passwordField = TextFormField(
      onSaved: (valor) => _password = valor,
      validator: (valor){
        return valor.length < 6 ? 'O Campo Senha deve possuir mais que 6 caracteres' : null;
      },
      decoration: InputDecoration(
        hintText: 'Senha',
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: AnimatedContainer(
            duration: Duration(
              seconds: 2,
            ),
            curve: Curves.slowMiddle,
            color: test ? Colors.grey : Colors.redAccent,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Form(
                key: formLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/img/carfuelSplash.png', width: 100
                ),
                        Text(
                          test ? '' : 'Dados inválidos!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    emailField,
                    SizedBox(
                      height: 25,
                    ),
                    passwordField,
                    SizedBox(
                      height: 35,
                    ),
                    ButtonTheme(
                      minWidth: 160,
                      height: 50,
                      child: RaisedButton.icon(
                        onPressed: _validarLogin,
                        textColor: Colors.white,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        icon: Icon(Icons.home, size: 35,),
                        label: Text('Entrar', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonTheme(
                      minWidth: 160,
                      height: 50,
                      child: RaisedButton.icon(
                        onPressed: () => showDialog(context: context, builder: (context) => CadastrarUsuario()),
                        textColor: Colors.white,
                        color: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        icon: Icon(Icons.account_box, size: 35,),
                        label: Text('Cadastrar', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

