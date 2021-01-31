import 'package:flutter/material.dart';
import 'package:simplepro/MemberPage.dart';
import 'package:simplepro/ViewDetails.dart';
import 'package:simplepro/AdminPage.dart';

class Tabbar extends StatefulWidget {
 final String username;
 final String currentpage;

Tabbar({this.username, this.currentpage});


  @override
  State<StatefulWidget> createState() {
  return _TabbarState();
  }
}

class _TabbarState extends State<Tabbar> {
  
  int _selectedIndex = 0;
  
static var uname;

@override
void initState(){
    setState(()=>uname=widget.username);

  super.initState();
}

  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   List<Widget> _widgetOptions = <Widget>[
//   MemberPage(username: uname,),

//   AdminPage(),

//    ViewDetails(),
// ];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  @override
Widget build(BuildContext context) {


  List<Widget> widgetList(String u){
    List<Widget> _widgetOptions = <Widget>[
  MemberPage(username: u,),

  AdminPage(username: u,),

   ViewDetails(),
];
return _widgetOptions;
  }


  return Scaffold(
   appBar: AppBar(title: Text("Flutter learning"),),
    body: Center(
      child: widgetList(uname).elementAt(_selectedIndex),
    ),
    drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
               
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('School'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    ),
  );
}
}