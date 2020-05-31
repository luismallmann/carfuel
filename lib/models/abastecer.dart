class Abastecer{
  int _idAbastecimento;
  double _valor;
  double _quantidade;
  double _kmAtual;
  String _dataAbastecimento;
  int _FK_idCarro;


  Abastecer(this._idAbastecimento, this._valor, this._quantidade, this._kmAtual,
      this._dataAbastecimento, this._FK_idCarro);

  int get idAbastecimento => _idAbastecimento;

  set idAbastecimento(int value) {
    _idAbastecimento = value;
  }

  double get kmAtual => _kmAtual;

  double get quantidade => _quantidade;

  double get valor => _valor;

  String get dataAbastecimento => _dataAbastecimento;

  int get FK_idCarro => _FK_idCarro;

  Map<String, dynamic> toMap() {
    return {
      'valor': valor,
      'quantidade': quantidade,
      'kmAtual': kmAtual,
      'dataAbastecimento': _dataAbastecimento,
      'FK_idCarro': FK_idCarro
    };
  }

}