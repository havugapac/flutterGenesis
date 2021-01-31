import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
 
class Studentdata {

 String userName;
 String userEmail;
 String userPassword;
 
  Studentdata({
    this.userName,
    this.userEmail,
    this.userPassword
  });
 
  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      userName: json['user_name'],
      userEmail: json['user_email'],
      userPassword: json['user_password']
 
    );
  }
}
 
class ViewDetails extends StatefulWidget {
 
  ViewDetailsWidget createState() => ViewDetailsWidget();
 
}
 
class ViewDetailsWidget extends State<ViewDetails> {
 
  final String apiURL = 'https://pacwil.000webhostapp.com/getDatas.php';
 
  Future<List<Studentdata>> fetchStudents() async {
 
    var response = await http.get(apiURL);
 
    if (response.statusCode == 200) {
 
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
 
      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();
 
      return studentList;
      }
     else {
      throw Exception('Failed to load data from Server.');
    }
  }
 
  selectedItem(BuildContext context, String dataHolder) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(dataHolder),
        actions: <Widget>[
          FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
     },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: FutureBuilder<List<Studentdata>>(
      future: fetchStudents(),
      builder: (context, snapshot) {
 
      if (!snapshot.hasData) return Center(
        child: CircularProgressIndicator()
      );
 
      return ListView(
      children: snapshot.data
      .map((data) => Column(children: <Widget>[
        GestureDetector(
          onTap: (){selectedItem(context, data.userName);},
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
         
 
          Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Text('Name = ' + data.userName,
            style: TextStyle(fontSize: 21))),
 
          Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Text('Email = ' + data.userEmail.toString(),
            style: TextStyle(fontSize: 21))),
 
          Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Text('Password = ' + data.userPassword,
            style: TextStyle(fontSize: 21))),
          
      ]),),
 
      Divider(color: Colors.black),
      ],))
    .toList(),
    );
    },
  ));
 }
}