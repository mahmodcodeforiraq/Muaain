import 'package:ail_alkher/Model/People.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPeoplePage extends StatefulWidget {
  final People people;
  EditPeoplePage(this.people);
  @override
  State<StatefulWidget> createState() {
    return new StateEditPeoplePage();
  }
}

final peopleRefrence =
    FirebaseDatabase.instance.reference().child('Users').child('People');

class StateEditPeoplePage extends State<EditPeoplePage> {
  TextEditingController _nameOfFatherControlar;
  TextEditingController _numberOfchiledrenControlar;
  TextEditingController _phonenumberControlar;
  TextEditingController _addressControlar;
  TextEditingController _cityControlar;
  TextEditingController _muhafadaControlar;
  TextEditingController  _alhay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameOfFatherControlar = new TextEditingController(text: widget.people.nameOfFather);
    _numberOfchiledrenControlar = new TextEditingController(text: widget.people.number_of_chiledren);
    _phonenumberControlar = new TextEditingController(text: widget.people.phonenumber);
    _addressControlar = new TextEditingController(text: widget.people.address);
    _cityControlar = new TextEditingController(text: widget.people.city);
    _muhafadaControlar = new TextEditingController(text: widget.people.muhafada);
        _alhay = new TextEditingController(text: widget.people.alhay);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("تعديل معلومات العائلة"),
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
                controller: _nameOfFatherControlar,
                decoration: InputDecoration(
                    labelText: "اسم رب العائلة",
                    icon: new Icon(
                      Icons.assignment,
                      color: Color(0xffff006064),
                    ),
                    fillColor: Color(0xffff006064),
                    labelStyle: TextStyle(color: Color(0xffff006064))),
              ),
              new Padding(padding: EdgeInsets.only(top: 10)),
              new TextField(
                controller: _numberOfchiledrenControlar,
                decoration: InputDecoration(
                    labelText: "عدد االاطفال",
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
                  peopleRefrence.child(widget.people.id).set({
                    'id': widget.people.id,
                    'nameOfFather': _nameOfFatherControlar.text,
                    'number_of_chiledren': _numberOfchiledrenControlar.text,
                    'addres': _addressControlar.text,
                    'phoneNumber': _phonenumberControlar.text,
                    'locationaltitude': widget.people.locationaltitude,
                    'locationlongitude': widget.people.locationlongitude,
                    'muhafada': _muhafadaControlar.text,
                    'city': _cityControlar.text,
                    'alhay': _alhay.text,

                  }).then((_) {
                    Navigator.pop(context);
                  });
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
