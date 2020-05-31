class Carro{
  int _idCarro;
  String _modelo;
  String _fabricante;
  String _placa;
  int _ano;
  double _kmInicial;
  int _FK_idUsuario;

  Carro(this._idCarro, this._modelo, this._fabricante, this._placa, this._ano,
      this._kmInicial, this._FK_idUsuario);

  int get idCarro => _idCarro;

  set idCarro(int value) {
    _idCarro = value;
  }

  String get modelo => _modelo;

  int get FK_idUsuario => _FK_idUsuario;

  double get kmInicial => _kmInicial;

  int get ano => _ano;

  String get placa => _placa;

  String get fabricante => _fabricante;

  Map<String, dynamic> toMap() {
    return {
      'modelo': _modelo,
      'fabricante': _fabricante,
      'placa': _placa,
      'ano': _ano,
      'kmInicial': _kmInicial,
      'FK_idUsuario': _FK_idUsuario,
    };
  }
}
