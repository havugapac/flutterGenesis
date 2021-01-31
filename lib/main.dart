import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simplepro/Tabbar.dart';

void main() => runApp(new MyApp());

String username='';

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login PHP My Admin',     
      home: new MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/Tabbar': (BuildContext context)=> new Tabbar(username: username,),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

TextEditingController user=new TextEditingController();
TextEditingController pass=new TextEditingController();

String msg='';

Future<List> _login() async {

  final response = await http.post("https://pacwil.000webhostapp.com/login.php", body: {
    "username": user.text,
    "password": pass.text,
  });
   print(response.body);

  var datauser = json.decode(response.body);

  if(datauser.length==0){
    setState(() {
          msg="Login Fail";
        });
  }else{
    if(datauser[0]['type']=='admin'){
       Navigator.pushReplacementNamed(context, '/Tabbar');
    }else if(datauser[0]['type']=='member'){
      Navigator.pushReplacementNamed(context, '/MemberPage');
    }else if(datauser[0]['type']=='viewer'){
      Navigator.pushReplacementNamed(context, '/ViewDetails');
    }

    setState(() {
          username= datauser[0]['user_name'];
        });

  }

  return datauser;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Username",style: TextStyle(fontSize: 18.0),),
              TextField(   
                controller: user,                
                decoration: InputDecoration(
                  hintText: 'Username'
                ),           
                ),
              Text("Password",style: TextStyle(fontSize: 18.0),),
              TextField(  
                controller: pass,  
                obscureText: true,                
                 decoration: InputDecoration(
                  hintText: 'Password'
                ),                
                ),
              
              RaisedButton(
                child: Text("Login"),
                onPressed: (){
                  _login();
                },
              ),

              Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),)
             
            ],
          ),
        ),
      ),

    );
}
}