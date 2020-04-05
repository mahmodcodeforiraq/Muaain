
import 'package:ail_alkher/ui_pages/SettingsPageWithoutLogin.dart';
import 'package:ail_alkher/ui_pages/ViewPage/AhelAlkherListWithoutLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ViewPage/AhelAlkherList.dart';
import 'ViewPage/PeopleListWithoutlogin.dart';

class HomePageWithoutlogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateHomePageWithoutlogin();
  }

}



class StateHomePageWithoutlogin extends State<HomePageWithoutlogin>{

  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = <Widget>[


    new SettingsPageWithoutLogin(),//0
    new PeopleListWithoutLogin(),//1
    new AhelAlkherlistWithoutLogin() ,//2




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
      if (user != null) {
        Navigator.of(context).pushReplacementNamed('/HomePage');

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
              backgroundColor: Colors.blue,

              icon: Icon(Icons.settings,),
              title: Text('اعدادات'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,

              icon: Icon(Icons.people,),
              title: Text('العوائل المحتاجة'),
            ),

            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon:  Icon(Icons.person,),
              title:  Text('الاشخاص المعينين',),
            ),




          ]


      ),

      body:  new Container(
        child:_widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

}