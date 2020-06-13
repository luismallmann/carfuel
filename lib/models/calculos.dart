import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/models/abastecer.dart';
import 'package:carfuel/models/carro.dart';

class Calculos {
  var base = DatabaseHelper();
  List<Abastecer> _listaAbastecidas;
  List<Carro> _carroDetalhado;


  Future<String> _buscarAbastecidas(int _FK_idCarro) async {
    var buscar = await base.listarAbastecimentoCarro(_FK_idCarro);
    _listaAbastecidas = buscar;
    return 'ok';
  }
  Future<String> _detalhaCarro(int idCarro) async {
    var buscar = await base.detalhaCarro(idCarro);
    _carroDetalhado = buscar;
    return 'ok';
  }

  Future<String> gastoVeiculo(int idCarro) async {
    var buscar = await _buscarAbastecidas(idCarro);
    buscar = await _detalhaCarro(idCarro);
    double somaKm = 0.0;
    double somaValor = 0.0;
    double media = 0.0;
    double kmAnterior = _carroDetalhado.elementAt(0).kmInicial;

    for (int i = 0; i < _listaAbastecidas.length; i++) {
      somaKm += (_listaAbastecidas.elementAt(i).kmAtual - kmAnterior);
      somaValor += _listaAbastecidas.elementAt(i).quantidade * _listaAbastecidas.elementAt(i).quantidade;
      kmAnterior = somaKm;
    }

    media = somaValor / somaKm;

    return media.toStringAsPrecision(3);
  }

  Future<String> gastoTotal(int idUser) async {
    double calcTotal=0;
    String valorConverter;
    var listaCarro = await base.listarCarros(idUser);

    for(int i=0;i<listaCarro.length;i++){
      valorConverter = await gastoVeiculo(listaCarro.elementAt(i).idCarro);
      calcTotal += double.parse(valorConverter);
    }

    calcTotal = calcTotal/listaCarro.length;

    return calcTotal.toStringAsPrecision(3);
  }

  Future<String> mediaVeiculo(int idCarro) async {
    var buscar = await _buscarAbastecidas(idCarro);
    buscar = await _detalhaCarro(idCarro);
    double somaKm = 0.0;
    double somaLitros = 0.0;
    double media = 0.0;
    double kmAnterior = _carroDetalhado.elementAt(0).kmInicial;


    for (int i = 0; i < _listaAbastecidas.length; i++) {
      somaKm += (_listaAbastecidas.elementAt(i).kmAtual - kmAnterior);
      somaLitros += _listaAbastecidas.elementAt(i).quantidade;
      kmAnterior = somaKm;
    }

    media = somaKm / somaLitros;

    return media.toStringAsPrecision(3);
  }

  Future<String> mediaTotal(int idUser) async {
    double calcTotal=0;
    String valorConverter;
    var listaCarro = await base.listarCarros(idUser);

    for(int i=0;i<listaCarro.length;i++){
      valorConverter = await mediaVeiculo(listaCarro.elementAt(i).idCarro);
      calcTotal += double.parse(valorConverter);
    }

    calcTotal = calcTotal/listaCarro.length;

    return calcTotal.toStringAsPrecision(3);
  }

}
