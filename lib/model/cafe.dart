class Cafe {
  //Atributos
  String _id;
  String _nome;
  double _preco;

  //Construtor
  Cafe(this._id, this._nome, this._preco);

  //Getters
  String get id => _id;
  String get nome => _nome;
  double get preco => _preco;

  Cafe.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._preco = obj['preco'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["nome"] = _nome;
    map["preco"] = _preco;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Cafe.fromMap(Map<String, dynamic> map, String id) {
    //Atribuir id ao this._id, somente se id não for
    //nulo, caso contrário atribui '' (vazio).
    this._id = id ?? '';
    this._nome = map["nome"];
    this._preco = map["preco"];
  }
}
