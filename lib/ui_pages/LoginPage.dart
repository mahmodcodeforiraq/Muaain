import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';



class  LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateLoginPage();
  }

}

FirebaseAuth myAuth = FirebaseAuth.instance;
String uid;

class StateLoginPage extends State<LoginPage>{

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
ProgressDialog pr;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(backgroundColor:new Color(0xffff006064),
        elevation: 0,
      ),

      body: new ListView(
          children: <Widget>[

            new Container(
              alignment: Alignment.center,
              height: 200,
              color: new Color(0xffff006064),
              child: new Text('تسجيل الدخول',style: new TextStyle(fontSize: 30,color: Colors.white),),
            ),


            new Container(
              padding: EdgeInsets.all(50),
              child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new TextField(
                          controller: _email,
                          decoration: InputDecoration(labelText: 'البريد الالكتروني'),
                        ),

                        new TextField(
                          controller: _password,
                          decoration: InputDecoration(labelText: 'كلمة المرور'),
                          obscureText: true,
                        ),

                        new Padding(padding: EdgeInsets.only(top: 40)),


                        new Padding(padding: EdgeInsets.only(top: 40)),

                        new RaisedButton(onPressed: (){
                           pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
                                pr.update(progressWidget: new Text('الرجاء الانتظار'));
                                pr.show();

                                    myAuth.signInWithEmailAndPassword(email: _email.text,
                                        password: _password.text).then((user){
                                      getUID();
                                          pr.hide();

                                      Navigator.of(context).pushReplacementNamed('/HomePage');

                                    }).catchError((onError){
                                      pr.hide();
                                      Fluttertoast.showToast(
                                          msg: "تأكد من ادخال البيانات او تأكد من الاتصال بالانترنت",
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 10);

                                    });



                        },
                          elevation: 5,
                          color: new Color(0xffff006064),
                          shape: RoundedRectangleBorder(
                              borderRadius:new BorderRadius.circular(10)),

                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              new Text('تسجيل الدخول',style: new TextStyle(fontSize: 25,color: Colors.white),),

                            ],
                          ),
                        ),


                      ],
                    ),
                  )

                ],
              ),
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new FlatButton(onPressed: (){
                  Navigator.of(context).pushNamed('/Register');
                },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text('انشاء حساب',style: TextStyle(fontSize: 20,color: Color(0xffff006064),fontWeight: FontWeight.bold),),
                        new Padding(padding: EdgeInsets.only(left: 15)),
                        new Icon(Icons.person_add,color: Color(0xffff006064),)
                      ],
                    )
                ),

                new Text('لا تمتلك حساب؟',
                    textDirection:TextDirection.ltr ,
                    style: new TextStyle(fontSize: 18,color: Colors.black ,)
                ),


              ],
            ),

          ]
      ),
    );
  }

  Future<String> getUID() async {
    final FirebaseUser user = await myAuth.currentUser();
    uid = user.uid;

    final pref = await SharedPreferences.getInstance();
    final key = 'uid';
    final value =uid;
    pref.setString(key, value);
    // here you write the codes to input the data into firestore
print(value);
    return uid;
  }

}