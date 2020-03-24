import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new StateAboutApp();
  }
}

class StateAboutApp extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("عن التطبيق"),
          centerTitle: true,
          backgroundColor: Color(0xffff006064),
          actions: <Widget>[],
        ),
        body: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Container(
                  child: new Image.asset(
                    'img/codeforiraq.png',
                    width: 300,
                    height: 300,
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 60),
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                new Text(
                  'دليل اطباء صلاح الدين',
                  style: TextStyle(fontSize: 18),
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                new Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: new Text(
                    "تطبيق يتيح للمستخدم الاستدلال و معرفة عناوين الاطباء في المحافظات و يمكن اضافة الاطباء عن طريق المستخدم العادي",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
