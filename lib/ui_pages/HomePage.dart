import 'package:ail_alkher/ui_pages/SettingsPageWithoutLogin.dart';
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

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[

    new AhelAlkherlist(),//0

    new PeopleList(),//1
    new SettingsPage(),//2





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
    getUser().then((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed('/HomepageWithoutLogin');

      }
    });


  }


  Future<FirebaseUser> getUser() async {
    return await myAuth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: new Color(0xffff006064),
        title: new Column(
          children: <Widget>[

            new Text('معين',style: TextStyle(fontSize: 21),),
            _selectedIndex==0? new Text('الاشخاص المعينين', style: TextStyle(fontSize: 10, color: Colors.white,)):
            _selectedIndex==1? new Text('العوائل المحتاجة', style: TextStyle(fontSize: 10, color: Colors.white,)):
            _selectedIndex==2? new Text('الاعدادات', style: TextStyle(fontSize: 10, color: Colors.white,)):

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

            BottomNavigationBarItem(
              backgroundColor: Colors.blue,

              icon: Icon(Icons.settings,),
              title: Text('اعدادات'),
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