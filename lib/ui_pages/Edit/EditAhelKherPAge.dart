import 'package:ail_alkher/Model/AhelAlkher.dart';
import 'package:ail_alkher/Model/People.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAhelKherPage extends StatefulWidget {
  final AhelAlkher ahelkher;
  EditAhelKherPage(this.ahelkher);
  @override
  State<StatefulWidget> createState() {
    return new StateEditAhelKherPage();
  }
}

final ahelkherRefrence =
    FirebaseDatabase.instance.reference();

class StateEditAhelKherPage extends State<EditAhelKherPage> {
  TextEditingController _nameController;
  TextEditingController _phonenumberControlar;
  TextEditingController _addressControlar;
  TextEditingController _cityControlar;
  TextEditingController _muhafadaControlar;
    TextEditingController _alhay;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.ahelkher.name);
    _phonenumberControlar = new TextEditingController(text: widget.ahelkher.phonenumber);
    _addressControlar = new TextEditingController(text: widget.ahelkher.address);
    _cityControlar = new TextEditingController(text: widget.ahelkher.city);
    _muhafadaControlar = new TextEditingController(text: widget.ahelkher.muhafada);
    _alhay = new TextEditingController(text: widget.ahelkher.alhay);



  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("تعديل معلومات المُعين"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xffff006064),
          actions: <Widget>[],
        ),
        body: new Container(
          padding: EdgeInsets.all(40),
          child: ListView(
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 10)),
              new TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: "الاسم",
                    icon: new Icon(
                      Icons.assignment,
                      color: Color(0xffff006064),
                    ),
                    fillColor: Color(0xffff006064),
                    labelStyle: TextStyle(color: Color(0xffff006064))),
              ),
              new Padding(padding: EdgeInsets.only(top: 10)),
              new TextField(
                controller: _addressControlar,
                decoration: InputDecoration(
                  labelText: "العنوان",
                  icon: new Icon(Icons.location_city, color: Color(0xffff006064)),
                  fillColor: Color(0xffff006064),
                  labelStyle: TextStyle(color: Color(0xffff006064)),
                ),
              ),
              new Padding(padding: EdgeInsets.only(top: 10)),
              new TextField(
                controller: _phonenumberControlar,
                decoration: InputDecoration(
                    labelText: "رقم هاتف ",
                    icon: new Icon(
                      Icons.phone,
                      color: Color(0xffff006064),
                    ),
                    fillColor: Color(0xffff006064),
                    labelStyle: TextStyle(color: Color(0xffff006064))),
              ),
              new Padding(padding: EdgeInsets.only(top: 10)),
              new TextField(
                controller: _muhafadaControlar,
                decoration: InputDecoration(
                  labelText: "المحافظة",
                  icon: new Icon(Icons.confirmation_number,
                      color: Color(0xffff006064)),
                  fillColor: Color(0xffff006064),
                  labelStyle: TextStyle(color: Color(0xffff006064)),
                ),
              ),
              new Padding(padding: EdgeInsets.only(top: 10)),
              new TextField(
                controller: _cityControlar,
                decoration: InputDecoration(
                    labelText: "المدينة",
                    icon: new Icon(
                      Icons.location_on,
                      color: Color(0xffff006064),
                    ),
                    fillColor: Color(0xffff006064),
                    labelStyle: TextStyle(color: Color(0xffff006064))),
              ),
               new Padding(padding: EdgeInsets.only(top: 10)),
              new TextField(
                controller: _alhay,
                decoration: InputDecoration(
                    labelText: "الحي",
                    icon: new Icon(
                      Icons.location_on,
                      color: Color(0xffff006064),
                    ),
                    fillColor: Color(0xffff006064),
                    labelStyle: TextStyle(color: Color(0xffff006064))),
              ),

              new Padding(padding: EdgeInsets.only(top: 30)),
              new RaisedButton(


                onPressed: () {
                   ahelkherRefrence.child('Users').child('Muaain').child(widget.ahelkher.id).set({
                    'id': widget.ahelkher.id,
                    'name': _nameController.text,
                    'addres': _addressControlar.text,
                    'phoneNumber': _phonenumberControlar.text,
                    'locationaltitude': widget.ahelkher.locationaltitude,
                    'locationlongitude': widget.ahelkher.locationlongitude,
                    'muhafada': _muhafadaControlar.text,
                    'city': _cityControlar.text,
                    'alhay': _alhay.text,


                  }).then((_) {
                    Navigator.pop(context);
                  });
                print(widget.ahelkher.id);
                },
                child: new Text('تعديل البيانات',style: TextStyle(fontSize: 20,color: Colors.white),),
                color: Color(0xffff006064),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10),
                ),
              ),
              new Padding(padding: EdgeInsets.only(top: 50)),
            ],
          ),
        ));
  }

}
