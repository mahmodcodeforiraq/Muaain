import 'package:ail_alkher/Model/People.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



FirebaseAuth myAuth = FirebaseAuth.instance;

final peopleRefrance = FirebaseDatabase.instance.reference().child('Users').child('People');

class AddPeople extends StatefulWidget{
  final People people;
  AddPeople(this.people);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateAddAddPeople();
  }

}


class StateAddAddPeople extends State<AddPeople>{

  String  locationaltitude;
  String locationlongitude;



  TextEditingController _nameOffather= new TextEditingController();
  TextEditingController _numberOfChiledren= new TextEditingController();
  TextEditingController _address= new TextEditingController();
  TextEditingController _mohafada= new TextEditingController();
  TextEditingController _city= new TextEditingController();
  TextEditingController _phonenumber= new TextEditingController();
  TextEditingController _alhay=new TextEditingController();




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("اضافة عائلة"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xffff006064),
        actions: <Widget>[],
      ),

      body:new Container(
        padding: EdgeInsets.all(30),
        child: new ListView(
          children: <Widget>[


            new TextField(
              controller: _nameOffather,
              decoration: InputDecoration(labelText: 'اسم رب العائلة',),
            ),


            new TextField(
              controller: _numberOfChiledren,
              decoration: InputDecoration(labelText: 'عدد الاطفال',),
            ),

            new TextField(
              controller: _address,
              decoration: InputDecoration(labelText: 'العنوان'),
            ),

            new TextField(
              controller: _mohafada,
              decoration: InputDecoration(labelText: 'محافظة'),
            ),

            new TextField(
              controller: _city,
              decoration: InputDecoration(labelText: 'قضاء'),
            ),

            new TextField(
              controller: _alhay,
              decoration: InputDecoration(labelText: 'الحي'),
            ),
            new TextField(
              controller: _phonenumber,
              decoration: InputDecoration(labelText: 'رقم هاتف'),
            ),
            new Padding(padding: EdgeInsets.only(top: 10)),

            new RaisedButton(onPressed: (){

              getMyLocation();
            },
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('موقعي على الخريطة',style: new TextStyle(fontSize: 18,color: Colors.white),),
                  new Padding(padding: EdgeInsets.only(left: 30)),

                  new Icon(Icons.location_on,color: Colors.white,)
                ],
              ),
              color: Color(0xffff006064),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10)
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new Container(
                  alignment:Alignment.topCenter ,
                  width: 130,
                  child: new Text('خط العرض $locationaltitude',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),

                ),
                new Container(
                  alignment: Alignment.center,

                  width: 130,

                  child:new Text('خط الطول $locationlongitude',textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),

                ),

              ],
            ),
            new Padding(padding: EdgeInsets.only(top: 20)),

            new RaisedButton(onPressed: (){

              insertData();
            },
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('حفظ البيانات',style: new TextStyle(fontSize: 18,color: Colors.white),),
                  new Padding(padding: EdgeInsets.only(left: 15)),

                  new Icon(Icons.save,color: Colors.white,)
                ],
              ),
              color: Color(0xffff006064),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10)
              ),
            ),



          ],
        ),
      ),
    );
  }

  Future insertData()async{

    var id = peopleRefrance.push().key;

    setState(() {

      peopleRefrance.child(id).set({
        'id': id,
        'nameOfFather': _nameOffather.text,
        'number_of_chiledren': _numberOfChiledren.text,
        'addres': _address.text,
        'phoneNumber': _phonenumber.text,
        'locationaltitude':locationaltitude,
        'locationlongitude': locationlongitude,
        'muhafada': _mohafada.text,
        'city': _city.text,
        'alhay': _alhay.text,
      }).then((_) {
        Navigator.of(context).pushReplacementNamed('/HomePage');
      });

    });

  }


  void getMyLocation()async{

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    print(position);
    setState(() {
      locationaltitude = '${position.latitude}';//خط العرض
      locationlongitude = '${position.longitude}';//خط الطول


    });


  }
}
