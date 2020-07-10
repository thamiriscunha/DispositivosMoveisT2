import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_plotze/model/item.dart';

class CadastroItem extends StatefulWidget {
  @override
  _CadastroItemState createState() => _CadastroItemState();
}

class _CadastroItemState extends State<CadastroItem> {
  TextEditingController _txtNome = TextEditingController();
  TextEditingController _txtQuantidade = TextEditingController();

  //instância do Firebase
  var db = Firestore.instance;

  //retornar dados do documento a partir do idDocument
  void getDocumento(String idDocumento) async {
    //Recuperar o documento no Firestore
    DocumentSnapshot doc =
        await db.collection("item").document(idDocumento).get();

    setState(() {
      _txtNome.text = doc.data["nome"];
      _txtQuantidade.text = doc.data["quantidade"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String idDocumento = ModalRoute.of(context).settings.arguments;

    if (idDocumento != null) {
      if (_txtNome.text == "" && _txtQuantidade.text == "") {
        getDocumento(idDocumento);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Itens Lista"),
        centerTitle: true,
        backgroundColor: Colors.blue,        
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            //CAMPO NOME
            TextField(
              controller: _txtNome,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Nome",
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //CAMPO Quantidade
            TextField(
              controller: _txtQuantidade,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Quantidade",
              ),
            ),
            SizedBox(
              height: 30,
            ),

            //BOTÕES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text("Salvar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      //
                      // Inserir ou Atualizar
                      //
                      if (idDocumento == null) {
                        inserir(context, 
                          Item(idDocumento, _txtNome.text,
                                double.parse(_txtQuantidade.text)));
                      } else {
                        atualizar(context,
                            Item(idDocumento, _txtNome.text,
                                double.parse(_txtQuantidade.text)));
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 140,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text("Cancelar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
   //
  // ATUALIZAR
  //
  void atualizar(BuildContext context, Item item) async {
    await db
        .collection("item")
        .document(item.id)
        .updateData({"nome": item.nome, "quantidade": item.quantidade});
    Navigator.pop(context);
  }

  //
  // INSERIR
  //
  void inserir(BuildContext context, Item item) async {
    await db.collection("item").add({
      "nome": item.nome,
      "quantidade": item.quantidade,
    });
    Navigator.pop(context);
  }

}
