import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_plotze/model/item.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
    //controles para os campos de texto
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtQuantidade = TextEditingController();

  //instância do Firebase
  var db = Firestore.instance;

  void getDocumento(String idDocumento) async {
    DocumentSnapshot doc =
        await db.collection("item").document(idDocumento).get();
    setState(() {
      txtNome.text =doc.data["nome"];
      txtQuantidade.text = doc.data["quantidade"].toStringAsFixed(0);
    });
  }
  @override
  Widget build(BuildContext context) {
    final String idDocumento = ModalRoute.of(context).settings.arguments;
    if (idDocumento != null) {
      print('idDocumento 2:'+idDocumento.toString());
      if (txtNome.text == "" && txtQuantidade.text == "") {
        getDocumento(idDocumento);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro Produto"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            TextField(
              controller: txtNome,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Nome",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtQuantidade,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                labelText: "Quantidade",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  child: RaisedButton(
                    color: Colors.blue[500],
                    child: Text("Salvar",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      if (idDocumento == null) {
                        print("--------------- null");
                        inserir(context, 
                          Item(idDocumento, txtNome.text,
                                double.parse(txtQuantidade.text)));
                      } else {
                        print("--------------- not null");
                        atualizar(context,
                            Item(idDocumento, txtNome.text,
                                double.parse(txtQuantidade.text)));
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
                    color: Colors.blue[500],
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

  void atualizar(BuildContext context, Item item) async {
    await db
        .collection("item")
        .document(item.id)
        .updateData({"nome": item.nome, "quantidade": item.quantidade});
    Navigator.pop(context);
  }

  void inserir(BuildContext context, Item item) async {
    await db.collection("item").add({
      "nome": item.nome,
      "quantidade": item.quantidade,
    });
    Navigator.pop(context);
  }

}