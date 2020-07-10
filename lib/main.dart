import 'package:flutter/material.dart';
import 'package:projeto_plotze/loginScreen.dart';
import 'package:projeto_plotze/telaCadastro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: "/principal",
      routes: {
        "/principal": (context) => LoginScreen(),
        "/cadastro": (context) => TelaCadastro(),
      },
      title: 'Flutter Demo',
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: ListPage(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.blue[300],
        backgroundColor: Colors.pink[300],
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCadastro()));
        },
      ),
    );
  }
}
//--------------------------------------------------
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async{
    var firestore = Firestore.instance;
    String colecao = 'item';
    QuerySnapshot qn = await firestore.collection(colecao).getDocuments();
    return qn.documents;
  }
  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post,)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(   
      decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:[
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              )
            ),   
      child:  StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("item").snapshots(),        
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('Loading...'),
          );
        }else{
          return ListView.builder(              
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
                return Card(
                  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                  color: Colors.blue[300],
                  child: ListTile(
                    title: Text(snapshot.data.documents[index].data['nome']),
                    subtitle: Text(snapshot.data.documents[index].data['quantidade'].toStringAsFixed(0)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Firestore.instance.collection("item").document(snapshot.data.documents[index].documentID).delete();
                      }),
                    onTap: () {                    
                      Navigator.pushNamed(context, "/cadastro", arguments: snapshot.data.documents[index].documentID);
                    },
                  ),
                );  
              });
          }})
    );
  }
}
//--------------------------------------------------------
class DetailPage extends StatefulWidget {
  final DocumentSnapshot post; 
  DetailPage({this.post});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: Container(
        child: Card(
            child : ListTile(
              title: Text('Produto: '+widget.post.data["nome"]),
              subtitle: Text('Quantidade: '+widget.post.data["quantidade"].toString()
            ),
            )
        )
      ),
    );
  }
}

