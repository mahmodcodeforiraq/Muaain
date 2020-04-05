import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTeam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new StateAboutTeam();
  }
}

class StateAboutTeam extends State<AboutTeam> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("فريق العمل"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xffff006064),
          actions: <Widget>[],
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
              height: 200,
              color:Color(0xffff006064),

              child: new Image.asset(
                'img/logo.png',height: 150,width: 150,

              ),
              alignment: Alignment.center,
            ),

            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                new Padding(padding: EdgeInsets.only(top: 20)),

                new Container(
                  alignment: Alignment.center,
                  child: new Text(
                    'البرمجة من اجل العراق  ',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                new Container(
                  alignment: Alignment.center,
                  child: new Text(
                    'فريق صلاح الدين',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),

                new Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: new Column(
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(top: 30)),

                        new Row(
                              children: <Widget>[
                                    new FlatButton(
                                        onPressed: () {
                                          launch(
                                              'https://www.facebook.com/mahm00d.nory');
                                        },
                                        child: new Column(
                                          children: <Widget>[
                                            new Image.asset('img/mahmod.png'),
                                            new Text('مبرمج المشروع',style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        )),

                                    new FlatButton(
                                        onPressed: () {
                                          launch('https://www.facebook.com/AbuAlror');
                                        },
                                        child: new Column(
                                          children: <Widget>[
                                            new Image.asset('img/marwan.png'),
                                            new Text('مدير المشروع',style: TextStyle(fontWeight: FontWeight.bold)),
                                            new Text('ومصمم الـ UI',style: TextStyle(fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,),
                                          ],
                                        )
                                    ),
                                  ],
                                ),

//
                              ],
                            ),



                )
              ],
            ),
          ],
        ));
  }
}
