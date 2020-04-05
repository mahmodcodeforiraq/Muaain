import 'dart:async';

import 'package:ail_alkher/Model/People.dart';
import 'package:ail_alkher/ui_pages/Edit/EditPeoplepage.dart';
import 'package:ail_alkher/ui_pages/InfoPeoplePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';






final peopleRefrance = FirebaseDatabase.instance.reference().child('Users').child('People');

String dropdownValue ;

String userid;
class PeopleList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StatePeopleList();
  }

}

class StatePeopleList extends State<PeopleList>{


  Query fireQuery;



  List<People> items;
  List<People> items2;


  StreamSubscription<Event> _onDoctorAddedSubscription;
  StreamSubscription<Event> _onDoctorChangedSubscription;



  @override
  void initState() {
    super.initState();

    items2 = new List();
    items = new List();

    getUID();
    setState(() {
      items = items2;
      fireQuery = peopleRefrance;

      dropdownValue='اختر المحافظة';
      _onDoctorAddedSubscription = fireQuery.onChildAdded.listen(_onPeopleAdded);
      _onDoctorChangedSubscription = fireQuery.onChildChanged.listen(_onPeopleUpdated);


    });


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
    _onDoctorAddedSubscription.cancel();
    _onDoctorChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        floatingActionButton:new Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.bottomLeft,
          child:  new FloatingActionButton(onPressed: (){
            Navigator.of(context).pushNamed('/AddPeopleNeeded');
          },
            child: new Icon(Icons.person_add,size: 25,),
            backgroundColor: new Color(0xffff006064),

          ),
        ),


      body: new Stack(
        children: <Widget>[
          new Container(
            alignment: Alignment.topCenter,
            height: 50,

            child: FlatButton(onPressed: (){

              Alert();
            },

                child: new Row(
                  children: <Widget>[
                    new Text('تصفية حسب المحافظة'),
                    new Icon(Icons.filter_list)
                  ],
                )
            ),
          ),




          new Container(
            padding: EdgeInsets.all(10),

            margin: EdgeInsets.only(top: 50),
            child:new ListView.builder(
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

//                                                 new Container(
//                                                    width: 100,
//
//                                                    height: 40,
//                                                    child: new Card(
//                                                      color: Color(0xffff006064),
//                                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20),
//                                                          side:BorderSide(width: 2,color: Colors.white)),
//
//                                                      child: new FlatButton(
//                                                          child:
//                                                          new Row(
//                                                            children: <Widget>[
//                                                              new Icon(
//                                                                Icons.edit,
//                                                                color: Colors.black45,
//                                                                size: 15,
//                                                              ),
//                                                              new Text("تعديل",
//                                                                style: TextStyle(color: Colors.white,
//                                                                    fontWeight: FontWeight.bold,
//                                                                    fontSize: 14),
//                                                              )
//                                                            ],
//
//                                                          ),
//                                                          onPressed: () =>
//                                                              _navigateToEditPeople(
//                                                                  context, items[position])),
//                                                    ),
//                                                    margin: EdgeInsets.only(
//                                                        right: 150),
//
//                                                  ),

                                                  new Container(
                                                    height: 10,
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
                                  _navigateToPeopleInformation(
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




  void _onPeopleAdded(Event event) {
    setState(() {
      items.add(new People.fromSnapShot(event.snapshot));
    });
  }

  void _onPeopleUpdated(Event event) {
    var oldPeoplesValue =
    items.singleWhere((peoples) => peoples.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldPeoplesValue)] =
      new People.fromSnapShot(event.snapshot);
    });
  }

  void _navigateToEditPeople(BuildContext context, People doctor) async {
    await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => EditPeoplePage(doctor)),
    );
  }

  void _navigateToPeopleInformation(BuildContext context,
      People doctor) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoPeoplePage(doctor)),
    );
  }

//  void _createNewPeople(BuildContext context) async {
//    await Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (context) =>
//              AddPeople(People(null,
//                  '',
//                  '',
//                  '',
//                  '',
//                  '',
//                  '',
//                  '',
//                  '',
//                  '')
//              )
//      ),
//    );
//
//  }



  void SearchMuhafada(String SearchMuhafada)  {
    items.clear();


    setState(() {

      fireQuery =fireQuery.orderByChild('muhafada').startAt(dropdownValue).endAt(dropdownValue);

      String name,locationaltitude,locationlongitude,addres,phonenumber,city,muhafada,number_of_chiledren,alhay;

      fireQuery.once().then(( snapshot) {

        setState(() {

          if(snapshot.value == null ){

            Fluttertoast.showToast(
              msg: "لا يوجد هذا الاسم في هذه المحافظة",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 5,
            );
          }
          else{

            snapshot.value.forEach((key , value){

              name = value['name'].toString().trim();
              number_of_chiledren = value['number_of_chiledren'].toString().trim();

              addres = value['addres'].toString().trim();
              phonenumber = value['phoneNumber'].toString().trim();
              locationaltitude = value['locationaltitude'].toString().trim();
              locationlongitude = value['locationlongitude'].toString().trim();
              city = value['city'].toString().trim();
              alhay=value['alhay'].toString().trim();
              muhafada = value['muhafada'].toString().trim();

              items2.add(new People(key,name,number_of_chiledren,addres,
                  locationaltitude,locationlongitude,muhafada,city,phonenumber,alhay));
            });

          }


        });
      });
    });
  }

  Future<void> Alert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10),
              side: new BorderSide(color:Color(0xffff006064) ,
                  width: 3)
          ),
          elevation: 6,
          title: Text('تصفية حسب المحافظة',textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Container(
                  height: 50,
                  child:new DropDown() ,
                ),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Row(
                children: <Widget>[
                  new Text('تصفية',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  new Icon(Icons.filter_list,color: Colors.black,)
                ],
              ),
              onPressed: () {
                SearchMuhafada(dropdownValue);
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

}



class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
}



class DropDownWidget extends State {


  List <String> spinnerItems = [
    'اختر المحافظة',
    'دهوك',
    'اربيل',
    'سليمانية',
    'نينوى',
    'كركوك',
    'صلاح الدين',
    'ديالى',
    'الانبار',
    'بغداد',
    'بابل',
    'ذيقار',
    'النجف',
    'كربلاء',
    'القادسية ',
    'المثنى',
    'ميسان',
    'واسط',
    'البصرة'




  ] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        alignment: Alignment.center,
        height: 50,
        child :

        DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black45, fontSize: 18),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String data) {
            setState(() {
              dropdownValue = data;
            });
          },
          items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

      ),
    );
  }



}
