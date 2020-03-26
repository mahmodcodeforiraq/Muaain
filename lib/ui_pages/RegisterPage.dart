import 'package:ail_alkher/ui_pages/Add/AddMuaain.dart';
import 'package:ail_alkher/ui_pages/Add/AddPeopleNeeded.dart';
import 'package:ail_alkher/ui_pages/SettingsPageWithoutLogin.dart';
import 'package:ail_alkher/ui_pages/ViewPage/PeopleList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ViewPage/AhelAlkherList.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateRegisterPage();
  }

}


FirebaseAuth myAuth = FirebaseAuth.instance;

class StateRegisterPage extends State<RegisterPage>{

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[

    new AddMuaain(),//0

    new AddPeopleNeeded(),//1




  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: new Color(0xffff006064),
        title: new Column(
          children: <Widget>[
            _selectedIndex==0? new Text('مُعين', style: TextStyle(fontSize: 20, color: Colors.white,)):
            _selectedIndex==1? new Text('العوائل المحتاجة', style: TextStyle(fontSize: 20, color: Colors.white,)):

            new Text(' ')
          ],
        ),
        centerTitle: true,
      ),

      bottomNavigationBar:  new BottomNavigationBar(
          showUnselectedLabels: false,

          selectedItemColor: Colors.white,
          backgroundColor: new Color(0xffff006064),
          unselectedItemColor: Colors.black45,
          selectedLabelStyle:new TextStyle(color:  Color(0xffEEE8A9)) ,
          elevation: 10,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          iconSize: 30,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon:  Icon(Icons.person,),
              title:  Text('الاشخاص المعينين',),
            ),

            BottomNavigationBarItem(
              backgroundColor: Colors.blue,

              icon: Icon(Icons.people,),
              title: Text('العوائل المحتاجة'),
            ),


          ]


      ),


      body:  new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              child:
              _widgetOptions.elementAt(_selectedIndex),
            ),



          ],
        ),

      ),
    );
  }

}