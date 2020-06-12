import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/models/abastecer.dart';
import 'package:carfuel/models/carro.dart';

class Calculos {
  var base = DatabaseHelper();
  List<Abastecer> _listaAbastecidas;
  List<Carro> _listaCarros;


  Future<String> _buscarAbastecidas(int _FK_idCarro) async {
    var buscar = await base.listarAbastecimentoCarro(_FK_idCarro);
    _listaAbastecidas = buscar;
    return 'ok';
  }

  Future<String> gastoVeiculo(int idCarro) async {
    var buscar = await _buscarAbastecidas(idCarro);
    double somaKm = 0.0;
    double somaValor = 0.0;
    double media = 0.0;
    double kmAnterior;

    for (int i = 0; i < _listaAbastecidas.length; i++) {
      somaKm += _listaAbastecidas.elementAt(i).kmAtual;
      somaValor += _listaAbastecidas.elementAt(i).quantidade * _listaAbastecidas.elementAt(i).quantidade;
    }

    media = somaValor / somaKm;

    return media.toStringAsPrecision(3);
  }

  Future<String> gastoTotal(int idUser) async {
    double calcTotal=0;
    var listaCarro = await base.listarCarros(idUser);

    for(int i=0;i<listaCarro.length;i++){
      calcTotal = double.parse(gastoVeiculo(listaCarro.elementAt(i).idCarro));
    }
  }

  Future<String> mediaVeiculo(int idCarro) async {
    var buscar = await _buscarAbastecidas(idCarro);
    double somaKm = 0.0;
    double somaLitros = 0.0;
    double media = 0.0;

    for (int i = 0; i < _listaAbastecidas.length; i++) {
      somaKm += _listaAbastecidas
          .elementAt(i)
          .kmAtual;
      somaLitros += _listaAbastecidas
          .elementAt(i)
          .quantidade;
    }

    media = somaKm / somaLitros;

    return media.toStringAsPrecision(3);
  }
}
