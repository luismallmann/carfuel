import 'package:carfuel/db/database_helper.dart';
import 'package:carfuel/models/abastecer.dart';

class Calculos {
  var base = DatabaseHelper();
  List<Abastecer> _listaAbastecidas;

  Future<String> _buscarAbastecidas() async {
    var buscar = await base.listarAbastecimento();
    _listaAbastecidas = buscar;
    return 'ok';
  }

  Future<String> mediaGeral() async{
    var buscar = await _buscarAbastecidas();
    double somaKm = 0.0;
    double somaLitros = 0.0;
    double media = 0.0;

    for(int i = 0; i < _listaAbastecidas.length; i++){
      somaKm +=_listaAbastecidas.elementAt(i).kmAtual;
      somaLitros += _listaAbastecidas.elementAt(i).quantidade;
    }

    media = somaKm / somaLitros;

    return media.toStringAsPrecision(2);
  }


}

