import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {

MemberPage({this.username});
final String username;


  @override
  Widget build(BuildContext context) {
      print("USERNAME:  $username");


    return Scaffold(
 
      body: Column(
        children: <Widget>[
          Text('Hallo $username', style: TextStyle(fontSize: 20.0),),

          RaisedButton(
            child: Text("LogOUt"),
            onPressed: (){
              Navigator.pushReplacementNamed(context,'/MyHomePage');
            },
          ),
        ],
      ),
    );
  }
}