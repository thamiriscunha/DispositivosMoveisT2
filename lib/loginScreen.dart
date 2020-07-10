import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_plotze/constantes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:projeto_plotze/main.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;


  final _senha = TextEditingController();
  final _email = TextEditingController();

  Widget _buildEmailTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: <Widget>[
        Text(
          "Email",
          style: kLabelStyle
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white,fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white
                ),
                hintText: 'Entre com o e-mail',
                hintStyle: kHintTextStyle
                ),                            
          ),
        )
      ],
    );
  }

  Widget _builtPasswordTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: <Widget>[
        Text(
          "Password",
          style: kLabelStyle
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _senha,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white
                ),
                hintText: 'Entre com a senha',
                hintStyle: kHintTextStyle
                ),                            
          ),
        )
      ],
    );    
  }

  Widget _buildSignBtn(context){
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: (){
            setState(() {
              final bool emailBool = EmailValidator.validate(_email.text);
             /* if(senhaBool == true){
                print('Email válido.');
              }else{
                print('Email invalido.');
              }*/
              if(emailBool == false && _senha.text.isNotEmpty && _senha.text.length > 6){
              showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                  title:Text(
                    "Ops algo deu erro...",
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  content:Text("E-mail inválido.",
                      style: TextStyle(
                      color: Color(0xFF527DAA),
                    ),),
                  actions: <Widget>[                    
                      new RaisedButton(
                        color: Color(0xFF527DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        }, 
                      child:new Text(
                        "Fechar",
                        style: TextStyle(
                          color: Colors.white,
                        ),                        
                        )
                      )                          
                  ],
                  );
                },
              );}else{              
              if(emailBool == true && (_senha.text.isEmpty || _senha.text.length < 6)){
                showDialog(
                  context: context,
                  builder: (context){
                  return AlertDialog(
                  title:Text(
                    "Ops algo deu erro...",
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  content:Text("O campo senha está em branco ou tem menos de 6 caracteres.",
                      style: TextStyle(
                      color: Color(0xFF527DAA),
                    ),),
                  actions: <Widget>[                    
                      new RaisedButton(
                        color: Color(0xFF527DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        }, 
                      child:new Text(
                        "Fechar",
                        style: TextStyle(
                          color: Colors.white,
                        ),                        
                        )
                      )                          
                  ],
                  );
                }
                );
              }else{
                if(_email.text.isEmpty  && _senha.text.isEmpty){
                  showDialog(
                  context: context,
                  builder: (context){
                  return AlertDialog(
                  title:Text(
                    "Ops algo deu erro...",
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  content:Text("O campo senha e e-mail estão em branco.",
                      style: TextStyle(
                      color: Color(0xFF527DAA),
                    ),),
                  actions: <Widget>[                    
                      new RaisedButton(
                        color: Color(0xFF527DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        }, 
                      child:new Text(
                        "Fechar",
                        style: TextStyle(
                          color: Colors.white,
                        ),                        
                        )
                      )                          
                  ],                                    
                  );
                });
                }else{
                  print("Autenticacao firebase");
                  register(context);
                }
              }
            }});                                
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
          color: Colors.white,
          child: Text(
            'SIGNIN',
            style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'
            ),
            ),
          ),                    
      );
  } 

  void register(BuildContext context) async{
    try{
      AuthResult result = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: _email.text, password: _senha.text);
      FirebaseUser user = result.user;     
    }catch(erro){
      print(erro.message);
      showDialog(
        context: context,
        builder: (context){
                  return AlertDialog(
                  title:Text(
                    "Ops algo deu erro...",
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  content:Text(erro.message,
                      style: TextStyle(
                      color: Color(0xFF527DAA),
                    ),),
                  actions: <Widget>[                    
                      new RaisedButton(
                        color: Color(0xFF527DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        }, 
                      child:new Text(
                        "Fechar",
                        style: TextStyle(
                          color: Colors.white,
                        ),                        
                        )
                      )                          
                  ],                                    
                  );
                }
      );
    }
  }

Widget _buildLoginBtn(context){
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: (){
            setState(() {
              final bool emailBool = EmailValidator.validate(_email.text);
              if(emailBool == false && _senha.text.isNotEmpty && _senha.text.length > 6){
              showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                  title:Text(
                    "Ops algo deu erro...",
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  content:Text("E-mail inválido.",
                      style: TextStyle(
                      color: Color(0xFF527DAA),
                    ),),
                  actions: <Widget>[                    
                      new RaisedButton(
                        color: Color(0xFF527DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        }, 
                      child:new Text(
                        "Fechar",
                        style: TextStyle(
                          color: Colors.white,
                        ),                        
                        )
                      )                          
                  ],
                  );
                },
              );}else{              
              if(emailBool == true && (_senha.text.isEmpty || _senha.text.length < 6)){
                showDialog(
                  context: context,
                  builder: (context){
                  return AlertDialog(
                  title:Text(
                    "Ops algo deu erro...",
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  content:Text("O campo senha está em branco ou tem menos de 6 caracteres.",
                      style: TextStyle(
                      color: Color(0xFF527DAA),
                    ),),
                  actions: <Widget>[                    
                      new RaisedButton(
                        color: Color(0xFF527DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        }, 
                      child:new Text(
                        "Fechar",
                        style: TextStyle(
                          color: Colors.white,
                        ),                        
                        )
                      )                          
                  ],
                  );
                }
                );
              }else{
                if(_email.text.isEmpty  && _senha.text.isEmpty){
                  showDialog(
                  context: context,
                  builder: (context){
                  return AlertDialog(
                  title:Text(
                    "Ops algo deu erro...",
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  content:Text("O campo senha e e-mail estão em branco.",
                      style: TextStyle(
                      color: Color(0xFF527DAA),
                    ),),
                  actions: <Widget>[                    
                      new RaisedButton(
                        color: Color(0xFF527DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        }, 
                      child:new Text(
                        "Fechar",
                        style: TextStyle(
                          color: Colors.white,
                        ),                        
                        )
                      )                          
                  ],                                    
                  );
                });
                }else{
                  print("Login - Autenticacao firebase");
                  doLogin(context);
                }
              }
            }});                                
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
          color: Colors.white,
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'
            ),
            ),
          ),                    
      );
  } 


void doLogin(BuildContext context) async{
    try{
      print('Email'+_email.text);
      AuthResult result = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: _email.text, password: _senha.text);
      print("E-mail:"+result.user.email);  
      print("Signed in:"+result.user.uid);  
      Navigator.push(context, MaterialPageRoute(builder:  (context) => MyHomePage()));     
    }catch(erro){
      print(erro.message);
      showDialog(
        context: context,
        builder: (context){
                  return AlertDialog(
                  title:Text(
                    "Ops algo deu erro...",
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  content:Text(erro.message,
                      style: TextStyle(
                      color: Color(0xFF527DAA),
                    ),),
                  actions: <Widget>[                    
                      new RaisedButton(
                        color: Color(0xFF527DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        }, 
                      child:new Text(
                        "Fechar",
                        style: TextStyle(
                          color: Colors.white,
                        ),                        
                        )
                      )                          
                  ],                                    
                  );
                }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
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
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color:Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),                  
                  ),
                  SizedBox(height: 30.0),
                  _buildEmailTF(),
                  SizedBox(height: 30.0),
                  _builtPasswordTF(),
                  SizedBox(height:20),
                  _buildLoginBtn(context),                  
                  _buildSignBtn(context),
                ],
              ),
            ),
          )

        ],
      ),
      
    );
  }
}