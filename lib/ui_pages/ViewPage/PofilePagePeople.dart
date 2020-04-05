import 'dart:async';
import 'package:ail_alkher/Model/People.dart';
import 'package:ail_alkher/ui_pages/Edit/EditPeoplepage.dart';
import 'package:ail_alkher/ui_pages/InfoPeoplePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ProfilePagePeople extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateProfilePagePeople();
  }

}



String value;



String dropdownValue ;
String userid;

FirebaseAuth myAuth = FirebaseAuth.instance;


class StateProfilePagePeople extends State<ProfilePagePeople>{

  bool _loading;
  double _progressValue;
  ProgressDialog pr;
  final profileReferance = FirebaseDatabase.instance.reference().child('Users')
      .child('userProfile').child('People').child('$value');


  List<People> items;

  StreamSubscription<Event> _onProfileAddedSubscription;
  StreamSubscription<Event> _onProfileChangedSubscription;

  loaduid() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'uid';
    value = pref.getString(key);
    print('uid : $value');

  }


  @override
  void initState() {
    super.initState();

      items = new List();
    loaduid();
    getUID();
      dropdownValue = 'اختر المحافظة';

    _onProfileAddedSubscription = profileReferance.onChildAdded.listen(_onProfileAdded);
    _onProfileChangedSubscription = profileReferance.onChildChanged.listen(_onProfileUpdated);


  }

  getUID() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userid=user.uid;
    print(userid);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onProfileAddedSubscription.cancel();
    _onProfileChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,


      body: new Stack(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(10),
//            margin: EdgeInsets.only(top: 50),
            child:
            new ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, position) {
                  return new Column(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
//
                      new Card(
                        elevation: 4,
                        child: new Column(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            new ListTile(
                              title: new Text(
                                '${items[position].nameOfFather}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                textDirection: TextDirection.rtl,
                              ),
                              subtitle: new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: new Container(
                                      child: new Column(
                                        children: <Widget>[
                                          new Container(
//
                                            child: new Container(
                                              child: new Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  new Text(
                                                    'رقم هاتف : ${items[position]
                                                        .phonenumber}',
                                                    style:
                                                    TextStyle(fontSize: 13,color:Colors.black45, ),
                                                    textDirection:
                                                    TextDirection.rtl,
                                                  ),
                                                  new Text(
                                                    "المحافظة ${items[position].muhafada}  | القضاء  ${items[position].city} | الحي ${items[position].alhay}",
                                                    style:
                                                    TextStyle(fontSize: 13,color:Colors.black45,),
                                                    textDirection:
                                                    TextDirection.rtl,
                                                  ),
                                                  new Text(
                                                    'اقرب نقطة دالة : ${items[position]
                                                        .address}',
                                                    style:
                                                    TextStyle(fontSize: 13,color:Colors.black45,),
                                                    textDirection:
                                                    TextDirection.rtl,
                                                  ),



                                                  new Row(

                                                    children: <Widget>[
                                                      new Container(
                                                        width: 100,

                                                        height: 40,
                                                        child: new Card(
                                                          color: Color(0xffff006064),
                                                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20),
                                                              side:BorderSide(width: 2,color: Colors.white)),

                                                          child: new FlatButton(
                                                              child:
                                                              new Row(
                                                                children: <Widget>[
                                                                  new Icon(
                                                                    Icons.edit,
                                                                    color: Colors.white,
                                                                    size: 15,
                                                                  ),
                                                                  new Padding(padding: EdgeInsets.only(left: 10)),

                                                                  new Text("تعديل",
                                                                    style: TextStyle(color: Colors.white,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 14),
                                                                  )
                                                                ],

                                                              ),
                                                              onPressed: () =>
                                                                  _navigateTopeople(
                                                                      context, items[position])),
                                                        ),
                                                      ),
                                                      new Container(

                                                        width: 100,
                                                        height: 40,
                                                        child: new Card(
                                                          color: Color(0xffff006064),
                                                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20),
                                                              side:BorderSide(width: 2,color: Colors.white)),

                                                          child: new FlatButton(
                                                              child:
                                                              new Row(
                                                                children: <Widget>[
                                                                  new Icon(
                                                                    Icons.delete,
                                                                    color: Colors.white,
                                                                    size: 15,
                                                                  ),
                                                                  new Padding(padding: EdgeInsets.only(left: 10)),
                                                                  new Text("حذف",
                                                                    style: TextStyle(color: Colors.white,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 14),
                                                                  )
                                                                ],

                                                              ),
                                                              onPressed:  (){
                                                                pr = new ProgressDialog(
                                                                    context, type: ProgressDialogType.Normal);
                                                                pr.update(
                                                                    progressWidget: new Text('الرجاء الانتظار'));
                                                                pr.show();

                                                                deleteUser (context, items[position],position);

                                                                deleteUserInMainList(context, items[position]).then((_){

                                                                  pr.hide().then((_){

                                                                  });

                                                                });


                                                              }

                                                          ),
                                                        ),

                                                      ),

                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () =>
                                  _navigateTopeopleInformation(
                                      context, items[position]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          )


        ],
      ),


    );
  }




  void _onProfileAdded(Event event) {
    setState(() {
      items.add(new People.fromSnapShot(event.snapshot));
    });
  }

  void _onProfileUpdated(Event event) {
    var oldPeoplesValue =
    items.singleWhere((people) => people.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldPeoplesValue)] =
      new People.fromSnapShot(event.snapshot);
    });
  }

  void _navigateTopeople(BuildContext context, People people) async {
    await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => EditPeoplePage(people)),
    );
  }

  void _navigateTopeopleInformation(BuildContext context,
      People people) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoPeoplePage(people)),
    );
  }
  deleteUser(BuildContext context,People people,int position) async {
    await profileReferance.child(people.id).remove().then((_){
      setState(() {
        items.removeAt(position);
      });
    });
  }
  deleteUserInMainList(BuildContext context,People people) async {
    final profileReferance = FirebaseDatabase.instance.reference().child('Users')
        .child('People');

    await profileReferance.child(people.id).remove();
  }



}

