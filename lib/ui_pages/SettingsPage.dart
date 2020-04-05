import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class  SettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateSettingsPage();
  }

}
FirebaseAuth myAuth = FirebaseAuth.instance;

class StateSettingsPage extends State<SettingsPage>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new ListView(
            children: <Widget>[

              new FlatButton(onPressed: (){
                myAuth.signOut();
                Navigator.of(context).pushReplacementNamed('/HomepageWithoutLogin');
              },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(' تسجيل الخروج',style: new TextStyle(fontSize: 20),),
                      new Padding(padding: EdgeInsets.only(left: 15)),
                      new Image.asset('img/login.png',scale: 1.5,),

                    ],
                  )),
              new Divider(color: Colors.black,)    ,

              new FlatButton(onPressed: (){
                Navigator.of(context).pushNamed('/AboutCodeForIraq');
              },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(left: 20)),

                      new Text(' عن المبادرة',style: new TextStyle(fontSize: 20),),
                      new Padding(padding: EdgeInsets.only(left: 10)),
                        new Icon(Icons.info),


                    ],
                  )),

              new Divider(color: Colors.black,)    ,

              new FlatButton(onPressed: (){
                Navigator.of(context).pushNamed('/AboutTeam');
              },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(left: 20)),

                      new Text(' عن الفريق',style: new TextStyle(fontSize: 20),),
                      new Padding(padding: EdgeInsets.only(left: 20)),
                      new Icon(Icons.people),
                    ],
                  )),
              new Divider(color: Colors.black,)    ,

              new FlatButton(onPressed: (){
                Navigator.of(context).pushNamed('/AboutApp');
              },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(left: 20)),

                      new Text(' عن التطبيق',style: new TextStyle(fontSize: 20),),
                      new Padding(padding: EdgeInsets.only(left: 20)),

                      new Icon(Icons.apps)
                    ],
                  )),

              new Divider(color: Colors.black,)    ,

              new FlatButton(onPressed: (){
              exit(0);
              },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(left: 20)),

                      new Text('خروج',style: new TextStyle(fontSize: 20),),
                      new Padding(padding: EdgeInsets.only(left: 20)),

                      new Icon(Icons.exit_to_app)
                    ],
                  )),

            ]

        )
    );
  }

}