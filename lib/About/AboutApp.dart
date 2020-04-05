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
          elevation: 0,
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
                  height: 200,
                  color:Color(0xffff006064),

                  child: new Image.asset(
                    'img/logo.png',height: 150,width: 150,

                  ),
                  alignment: Alignment.center,
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                new Text(
                  'مُعين',
                  style: TextStyle(fontSize: 18),
                ),
                new Padding(padding: EdgeInsets.only(top: 20)),
                new Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: new Text(
                    "تطبيق يساعد الذين يريدون مساعدة الناس والعوائل المحتاجة بالتعرف على ارقا م هواتفهم وعناوينهم وايضا موقعهم على الخريطة",
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
