import 'dart:async';
import 'package:ail_alkher/Model/AhelAlkher.dart';
import 'package:ail_alkher/ui_pages/Edit/EditAhelKherPAge.dart';
import 'package:ail_alkher/ui_pages/InfoielkherPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';






final ahelAlkherRefrance = FirebaseDatabase.instance.reference().child('Users').child('Muaain');


String dropdownValue ;
String userid;

FirebaseAuth myAuth = FirebaseAuth.instance;


class AhelAlkherlist extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateAhelAlkherlist();
  }

}

class StateAhelAlkherlist extends State<AhelAlkherlist>{




  Query fireQuery;



  List<AhelAlkher> items;
  List<AhelAlkher> items2;


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
      fireQuery = ahelAlkherRefrance;

      dropdownValue = 'اختر المحافظة';
    });

    _onDoctorAddedSubscription =
        ahelAlkherRefrance.onChildAdded.listen(_onDoctortAdded);
    _onDoctorChangedSubscription =
        ahelAlkherRefrance.onChildChanged.listen(_onDoctortUpdated);


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
      resizeToAvoidBottomPadding: false,


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
                                '${items[position].name}',
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

                                                  userid==items2[position].id? new Container(
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
                                                                color: Colors.black45,
                                                                size: 15,
                                                              ),
                                                              new Text("تعديل",
                                                                style: TextStyle(color: Colors.white,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 14),
                                                              )
                                                            ],

                                                          ),
                                                          onPressed: () =>
                                                              _navigateToAhelAlkher(
                                                                  context, items[position])),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 150),

                                                  ):
                                                      new Text(' ')

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
                                  _navigateToAhelAlkherInformation(
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




  void _onDoctortAdded(Event event) {
    setState(() {
      items.add(new AhelAlkher.fromSnapShot(event.snapshot));
    });
  }

  void _onDoctortUpdated(Event event) {
    var oldahelAlkhersValue =
    items.singleWhere((ahelAlkher) => ahelAlkher.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldahelAlkhersValue)] =
      new AhelAlkher.fromSnapShot(event.snapshot);
    });
  }

  void _navigateToAhelAlkher(BuildContext context, AhelAlkher ahelAlkher) async {
    await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => EditAhelKherPage(ahelAlkher)),
    );
  }

  void _navigateToAhelAlkherInformation(BuildContext context,
      AhelAlkher ahelAlkher) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoAhelkherPage(ahelAlkher)),
    );
  }






  void SearchDepartment(String searchDepartment)  {
    items.clear();


    setState(() {

      fireQuery =fireQuery.orderByChild('muhafada').startAt(dropdownValue).endAt(dropdownValue);

      String name,locationaltitude,locationlongitude,addres,phonenumber,city,muhafada,alhay;

      fireQuery.once().then(( snapshot) {

        setState(() {

          if(snapshot.value == null ){

            Fluttertoast.showToast(
              msg: "لا يوجد مُعين في هذه المحافظة",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 5,
            );
          }
          else{

            snapshot.value.forEach((key , value){

              name = value['name'].toString().trim();
              addres = value['addres'].toString().trim();
              phonenumber = value['phoneNumber'].toString().trim();
              locationaltitude = value['locationaltitude'].toString().trim();
              locationlongitude = value['locationlongitude'].toString().trim();
              city = value['city'].toString().trim();
              alhay = value['alhay'].toString().trim();

              muhafada = value['muhafada'].toString().trim();

              items2.add(new AhelAlkher(key, name, addres, locationaltitude,locationlongitude, muhafada, city, phonenumber,alhay));
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
