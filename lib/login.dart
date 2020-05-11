import 'package:flutter/material.dart';

class login extends StatelessWidget {
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

  //aqui vai a parte para validar

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      onSaved: (valor) => _email = valor,
      validator: (valor){
        return valor.length < 10 ? 'usuario > 10 carac' : null;
      },
      decoration: InputDecoration(
        hintText: 'Email',
      ),
    );

    final passwordField = TextFormField(
      onSaved: (valor) => _email = valor,
      validator: (valor){
        return valor.length < 10 ? 'senha > 10 carac' : null;
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
            //color: valida ? Colors.greenAccent : Colors.blueGrey,
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
                          'assets/img/carfuelSplash.png', width: 100,//color:  valida ? Colors.black : Colors.red,
                ),
                        Text('ajustar validação senha'),
                        /*Text(
                          //valida ? '' : 'Dados inválidos!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),*/
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
                    RaisedButton(
                      color: Colors.blue,
                      elevation: 5.0,
                      child: Text('Login'),
                      //onPressed: _validarLogin,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FlatButton(
                        onPressed: () => showDialog(context: context, /*builder: (context) => RegisterForm()*/),
                        child: Text('Registre-se', style: TextStyle(fontSize: 25, color: Colors.orange)))
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

