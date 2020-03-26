import 'package:ail_alkher/Model/AhelAlkher.dart';
import 'package:ail_alkher/Model/People.dart';
import 'package:ail_alkher/ui_pages/HomePage.dart';
import 'package:ail_alkher/ui_pages/HomePageWithoutLogin.dart';
import 'package:ail_alkher/ui_pages/LoginPage.dart';
import 'package:ail_alkher/ui_pages/RegisterPage.dart';
import 'package:flutter/material.dart';

import 'About/AboutApp.dart';
import 'About/AboutCodeForIraq.dart';
import 'About/AboutTeam.dart';


void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,

  theme: new ThemeData(fontFamily: 'Schyler'),

  home: new HomePage(),



    routes: <String, WidgetBuilder>{
      '/Login': (BuildContext context) => new LoginPage(),
     '/Register': (BuildContext context) => new RegisterPage(),
      '/HomePage': (BuildContext context) => new HomePage(),
      '/AboutCodeForIraq': (BuildContext context) => new AboutCodeForIraq(),
      '/AboutTeam': (BuildContext context) => new AboutTeam(),
      '/AboutApp': (BuildContext context) => new AboutApp(),
      '/HomepageWithoutLogin': (BuildContext context) => new HomePageWithoutlogin(),

    }
));

