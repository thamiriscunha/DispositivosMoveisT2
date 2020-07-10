class Item {
  //Atributos
  String _id;
  String _nome;
  double _quantidade;

  //Construtor
  Item(this._id, this._nome, this._quantidade);

  //Getters
  String get id => _id;
  String get nome => _nome;
  double get quantidade => _quantidade;

  Item.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._quantidade = obj['quantidade'];
  }

  //Converter os dados para um Mapa
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["nome"] = _nome;
    map["quantidade"] = _quantidade;
    return map;
  }

  //Converter um Mapa para o modelo de dados
  Item.fromMap(Map<String, dynamic> map, String id) {
    //Atribuir id ao this._id, somente se id não for
    //nulo, caso contrário atribui '' (vazio).
    this._id = id ?? '';
    this._nome = map["nome"];
    this._quantidade = map["quantidade"];
  }
}
