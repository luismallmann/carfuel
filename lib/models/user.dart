class User {
  int _id;
  String _name;
  String _email;
  String _password;

  User(this._id, this._name, this._email, this._password);

  int get id => _id;

  void set id(int id) => _id = id;

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