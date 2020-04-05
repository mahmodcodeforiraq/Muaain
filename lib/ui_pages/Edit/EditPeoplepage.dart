import 'package:ail_alkher/Model/People.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';



String dropdownValue;
class EditPeoplePage extends StatefulWidget {
  final People people;
  EditPeoplePage(this.people);
  @override
  State<StatefulWidget> createState() {
    return new StateEditPeoplePage();
  }
}


String value;

class StateEditPeoplePage extends State<EditPeoplePage> {
  TextEditingController _nameOfFatherControlar;
  TextEditingController _numberOfchiledrenControlar;
  TextEditingController _phonenumberControlar;
  TextEditingController _addressControlar;
  TextEditingController _cityControlar;
  TextEditingController _muhafadaControlar;
  TextEditingController _alhay;

  ProgressDialog pr;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameOfFatherControlar =
    new TextEditingController(text: widget.people.nameOfFather);
    _numberOfchiledrenControlar = new TextEditingController(text: widget.people.number_of_chiledren);
    _phonenumberControlar = new TextEditingController(text: widget.people.phonenumber);
    _addressControlar = new TextEditingController(text: widget.people.address);
    _cityControlar = new TextEditingController(text: widget.people.city);
    _alhay = new TextEditingController(text: widget.people.alhay);

    dropdownValue=widget.people.muhafada;
    loaduid();
  }


  loaduid() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'uid';
    value = pref.getString(key);
    print('uid : $value');
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
                  icon: new Icon(
                      Icons.location_city, color: Color(0xffff006064)),
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
              new Container(
                height: 50,
                child: new DropDown(),
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
                  pr = new ProgressDialog(
                      context, type: ProgressDialogType.Normal);
                  pr.update(
                      progressWidget: new Text('الرجاء الانتظار'));
                  pr.show();

                  updateInMainList();
                  updateInProfile().then((_) {
                    pr.hide();
                  });
                },
                child: new Text('تعديل البيانات',
                  style: TextStyle(fontSize: 20, color: Colors.white),),
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


  updateInMainList() {
    final peopleRefrence = FirebaseDatabase.instance.reference();

    peopleRefrence.child('Users').child('People').child(widget.people.id).set({
      'id': widget.people.id,
      'nameOfFather': _nameOfFatherControlar.text,
      'number_of_chiledren': _numberOfchiledrenControlar.text,
      'addres': _addressControlar.text,
      'phoneNumber': _phonenumberControlar.text,
      'locationaltitude': widget.people.locationaltitude,
      'locationlongitude': widget.people.locationlongitude,
      'muhafada':dropdownValue,
      'city': _cityControlar.text,
      'alhay': _alhay.text,


    }).then((_) {
      Navigator.pop(context);
    });
  }

  updateInProfile() {
    final peopleRefrence = FirebaseDatabase.instance.reference();

    peopleRefrence.child('Users').child('userProfile').child('People')
        .child('$value').child(widget.people.id).set({
      'id': widget.people.id,
      'nameOfFather': _nameOfFatherControlar.text,
      'number_of_chiledren': _numberOfchiledrenControlar.text,
      'addres': _addressControlar.text,
      'phoneNumber': _phonenumberControlar.text,
      'locationaltitude': widget.people.locationaltitude,
      'locationlongitude': widget.people.locationlongitude,
      'muhafada':dropdownValue,
      'city': _cityControlar.text,
      'alhay': _alhay.text,


    }).then((_) {
      Navigator.pop(context);
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
            color: new Color(0xffff006064),
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