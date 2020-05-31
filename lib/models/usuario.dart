class User {
  int _idUsuario;
  String _name;
  String _email;
  String _password;

  User(this._idUsuario, this._name, this._email, this._password);

  int get idUsuario => _idUsuario;

  void set idUsuario(int idUsuario) => _idUsuario = idUsuario;

  String get name => _name;

  String get email => _email;

  String get password => _password;

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'email': _email,
      'password': _password,
    };
  }
}