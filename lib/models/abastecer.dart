class Abastecer{
  int _idAbastecimento;
  double _valor;
  double _quantidade;
  double _kmAtual;
  int _FK_idCarro;


  Abastecer(this._idAbastecimento, this._valor, this._quantidade, this._kmAtual,
      this._FK_idCarro);

  int get idAbastecimento => _idAbastecimento;

  double get kmAtual => _kmAtual;

  double get quantidade => _quantidade;

  double get valor => _valor;

  int get FK_idCarro => _FK_idCarro;
}