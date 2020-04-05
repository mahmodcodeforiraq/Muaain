
import 'package:ail_alkher/ui_pages/ViewPage/PofilePageMuaain.dart';
import 'package:ail_alkher/ui_pages/ViewPage/PofilePagePeople.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';


class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateProfilePage();
  }

}


FirebaseAuth myAuth = FirebaseAuth.instance;

class StateProfilePage extends State<ProfilePage>{

  TabController _tabController;

  List tabList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
  body:GFTabs(
    height: 1000,
    tabBarColor: new Color(0xffff006064),
    initialIndex: 0,
    length: 2,
    tabs: <Widget>[
      Tab(
        icon: Icon(Icons.person),
        child: Text(
          "المُعين",
        ),
      ),
      Tab(
        icon: Icon(Icons.people),
        child: Text(
          "العوائل المحتاجة",
        ),
      ),

    ],
    tabBarView: GFTabBarView(
      children: <Widget>[
        Container(child: new ProfilePageMuaain()),
        Container(child: new ProfilePagePeople()),
      ],
    ),
  ),
    );
  }

}