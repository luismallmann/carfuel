import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/models/abastecer.dart';
import 'package:carfuel/models/carro.dart';
import 'package:carfuel/models/usuario.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastrarAbastecimento extends StatefulWidget {
  final User user;
  const CadastrarAbastecimento({Key key, this.user}): super(key: key);
  @override
  _CadastrarAbastecimentoState createState() => _CadastrarAbastecimentoState();
}

class _CadastrarAbastecimentoState extends State<CadastrarAbastecimento> {
  var base = DatabaseHelper();
  int  _idAbastecimento;
  String _valor;
  String _quantidade;
  String _kmAtual;
  String _FK_idCarro;
  String _dataAbastecimento;
  final dadosAbastecimento = new GlobalKey<FormState>();
  List<Carro> listaCarros;

  Future<String> _exibirCarros() async {
    var buscar = await base.listarCarros();

    setState(() {
      listaCarros = buscar;
      print('passei aqui'+listaCarros.length.toString());
    });
    return 'ok';
  }
  @override
  void initState() {
    super.initState();
    // Chama o método getJSONData() quando a app inicializa
    this._exibirCarros();
  }
  void _adicionarAbastecimento() async{
    final dadosAtuais = dadosAbastecimento.currentState;

    if(dadosAtuais.validate()){
      dadosAtuais.save();

      Abastecer abastecimento = Abastecer(null, double.parse(_valor), double.parse(_quantidade), double.parse(_kmAtual), _dataAbastecimento, int.parse(_FK_idCarro));

      abastecimento.idAbastecimento = await base.saveAbastecimento(abastecimento);

      if(abastecimento.idAbastecimento != null && abastecimento.idAbastecimento>0){
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
    int idUsuario = widget.user.idUsuario;
    return Form(
        key: dadosAbastecimento,
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
                          "Cadastrar Abastecimento",
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
                      DropdownButton<String>(
                        hint: Text('Selecione o veículo'),
                        items: listaCarros.map((c) {
                          return DropdownMenuItem(
                              value: c.idCarro.toString(),
                              child: Text(c.fabricante +'/'+c.modelo, style: TextStyle(color: Colors.black)));
                        }).toList(),
                        onChanged: (String selecionado) {
                          setState(() {
                            _FK_idCarro = selecionado;
                            print(_FK_idCarro);
                          });
                        },
                        value: _FK_idCarro,
                      ),
                  DateTimeField(
                    keyboardType: TextInputType.datetime,
                    format: DateFormat('dd/MM/yyyy'),
                    decoration: InputDecoration(labelText: 'Data do Abastecimento'),
                      onChanged: (data) {
                        setState(() {
                          //já salva no formata dd/mm/yyyy
                          _dataAbastecimento = data.day.toString()+'/'+data.month.toString()+'/'+data.year.toString();
                        });
                      },
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100)
                      );
                    },
                  ),
                      TextFormField(
                        onSaved: (valor) => _valor = valor,
                        decoration: InputDecoration(
                            labelText: "Valor (Reais)",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      TextFormField(
                        onSaved: (valor) => _quantidade = valor,
                        decoration: InputDecoration(
                            labelText: "Quantidade (litros)",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      TextFormField(
                        onSaved: (valor) => _kmAtual = valor,
                        decoration: InputDecoration(
                            labelText: "Quilometragem Atual",
                            hasFloatingPlaceholder: true
                        ),
                      ),
                      FlatButton(
                        color: Colors.green,
                        child: Text('Cadastrar'),
                        onPressed: _adicionarAbastecimento,
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
