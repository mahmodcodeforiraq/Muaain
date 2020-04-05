import 'package:ail_alkher/ui_pages/ProfilePage.dart';
import 'package:ail_alkher/ui_pages/ViewPage/PofilePageMuaain.dart';
import 'package:ail_alkher/ui_pages/SettingsPage.dart';
import 'package:ail_alkher/ui_pages/ViewPage/PeopleList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ViewPage/AhelAlkherList.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateHomePage();
  }

}


FirebaseAuth myAuth = FirebaseAuth.instance;

class StateHomePage extends State<HomePage>{

  int _selectedIndex = 3;

  final List<Widget> _widgetOptions = <Widget>[

    new SettingsPage(),//0
    new ProfilePage(),//2
    new PeopleList(),//1
    new AhelAlkherlist(),//3







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
        elevation: 5,
        backgroundColor: new Color(0xffff006064),
        title:new Text('مُعين',style: TextStyle(fontSize: 21),),
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
              backgroundColor: Color(0xffff006064),

              icon: Icon(Icons.settings,),
              title: Text('اعدادات'),
            ),



            BottomNavigationBarItem(
              backgroundColor: Color(0xffff006064),

              icon: Icon(Icons.person_pin,),
              title: Text('الصفحة الشخصية'),
            ),

            BottomNavigationBarItem(
              backgroundColor: Color(0xffff006064),

              icon: Icon(Icons.people,),
              title: Text('العوائل المحتاجة'),
            ),
            BottomNavigationBarItem(
              backgroundColor:  Color(0xffff006064),
              icon:  Icon(Icons.person,),
              title:  Text('الاشخاص المعينين',),
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