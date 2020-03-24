import 'package:ail_alkher/Model/AhelAlkher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class AddAhelAlkher extends StatefulWidget{

  final AhelAlkher ahelAlkher;
  AddAhelAlkher(this.ahelAlkher);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateAddAhelAlkher();
  }

}
final MuaainRefrance = FirebaseDatabase.instance.reference().child('Users').child('Muaain');

class StateAddAhelAlkher extends State<AddAhelAlkher>{


  String  locationaltitude;
  String locationlongitude;


  TextEditingController _name= new TextEditingController();
  TextEditingController _address= new TextEditingController();
  TextEditingController _mohafada= new TextEditingController();
  TextEditingController _city= new TextEditingController();
  TextEditingController _phonenumber= new TextEditingController();
  TextEditingController _alhay=new TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();


}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('اضافة معين',style: TextStyle(fontSize: 24),),
        centerTitle: true,
      ),

      body:new Container(
        padding: EdgeInsets.all(30),
        child: new ListView(
          children: <Widget>[



            new Padding(padding: EdgeInsets.only(top: 40)),

            new TextField(
              controller: _name,
              decoration: InputDecoration(labelText: 'الاسم'),
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
            new Padding(padding: EdgeInsets.only(top: 40)),
            
            new RaisedButton(onPressed: (){

              getMyLocation();
            },
              elevation: 5,
              color: Colors.blue,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('موقعي على الخريطة',style: new TextStyle(fontSize: 18,color: Colors.white),),
                  new Padding(padding: EdgeInsets.only(left: 10)),

                  new Icon(Icons.location_on)
                ],
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



            new Padding(padding: EdgeInsets.only(top: 40)),

            new RaisedButton(onPressed:insertData,
              elevation: 5,
              color: Colors.green,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('حفظ البيانات',style: new TextStyle(fontSize: 18,color: Colors.white),),
                  new Padding(padding: EdgeInsets.only(left: 10)),

                  new Icon(Icons.save)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Future insertData()async{

    var id = MuaainRefrance.push().key;

    setState(() {

      MuaainRefrance.push().set({
        'id': id,
        'name': _name.text,
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

