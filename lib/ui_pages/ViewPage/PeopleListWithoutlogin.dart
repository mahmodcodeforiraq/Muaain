import 'dart:async';

import 'package:ail_alkher/Model/People.dart';
import 'package:ail_alkher/ui_pages/Add/AddPeople.dart';
import 'package:ail_alkher/ui_pages/Edit/EditPeoplepage.dart';
import 'package:ail_alkher/ui_pages/InfoPeoplePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';






final peopleRefrance = FirebaseDatabase.instance.reference().child('Users').child('People');

String dropdownValue ;

class PeopleListWithoutLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StatePeopleListWithoutLogin();
  }

}

class StatePeopleListWithoutLogin extends State<PeopleListWithoutLogin>{


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


    setState(() {
      items = items2;
      fireQuery = peopleRefrance;

      dropdownValue='اختر المحافظة';
      _onDoctorAddedSubscription = fireQuery.onChildAdded.listen(_onPeopleAdded);
      _onDoctorChangedSubscription = fireQuery.onChildChanged.listen(_onPeopleUpdated);


    });


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


      body: new Stack(
        children: <Widget>[
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                alignment: Alignment.topRight,
                width: 100,
                child: FlatButton(onPressed: (){
                  SearchDepartment(dropdownValue);},

                    child: new Row(
                      children: <Widget>[
                        new Text('تصفية'),
                        new Icon(Icons.filter_list)
                      ],
                    )
                ),
              ),


              new Container(
                alignment: Alignment.topLeft,
                width: 130,
                child: DropDown(),
              ),


            ],
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
                                        'العنوان : ${items[position]
                                            .address}',
                                        style:
                                        TextStyle(fontSize: 13,color:Colors.black45,),
                                        textDirection:
                                        TextDirection.rtl,
                                      ),
                                      new Text(
                                        'رقم هاتف  : ${items[position]
                                            .phonenumber}',
                                        style:
                                        TextStyle(fontSize: 13,color:Colors.black45,),
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




  void SearchDepartment(String searchDepartment)  {
    items.clear();


    setState(() {

      fireQuery =fireQuery.orderByChild('muhafada').startAt(dropdownValue).endAt(dropdownValue);

      String name,locationaltitude,locationlongitude,addres,phonenumber,city,alhay,muhafada,number_of_chiledren;

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
              alhay = value['alhay'].toString().trim();

              muhafada = value['muhafada'].toString().trim();

              items2.add(new People(key,name,number_of_chiledren,addres,
                  locationaltitude,locationlongitude,muhafada,city,phonenumber,alhay));
            });

          }


        });
      });
    });
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
