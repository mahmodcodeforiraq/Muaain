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
          backgroundColor: Color(0xffff006064),
          actions: <Widget>[],
        ),
        body: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.all(30),
                  child: new Image.asset(
                    'img/codeforiraq.png',
                    width: 150,
                    height: 150,
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 40),
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                new Text(
                  'البرمجة من اجل العراق',
                  style: TextStyle(fontSize: 18),
                ),
                new Text(
                  'فريق صلاح الدين',
                  style: TextStyle(fontSize: 18),
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
                                            new Text('مبرمج المشروع'),
                                          ],
                                        )),

                                    new FlatButton(
                                        onPressed: () {
                                          launch('https://www.facebook.com/AbuAlror');
                                        },
                                        child: new Column(
                                          children: <Widget>[
                                            new Image.asset('img/marwan.png'),
                                            new Text('مدير المشروع'),
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
