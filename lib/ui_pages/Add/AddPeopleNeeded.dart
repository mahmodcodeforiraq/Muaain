import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';



String dropdownValue ;

class  AddPeopleNeeded extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateAddPeopleNeeded();
  }

}


FirebaseAuth myAuth = FirebaseAuth.instance;

String uid;
String idForall;
class StateAddPeopleNeeded extends State<AddPeopleNeeded>{




  String  locationaltitude;
  String locationlongitude;

ProgressDialog pr;

  TextEditingController _nameOfFather= new TextEditingController();
  TextEditingController _address= new TextEditingController();
  TextEditingController _mohafada= new TextEditingController();
  TextEditingController _city= new TextEditingController();
  TextEditingController _phonenumber= new TextEditingController();
  TextEditingController _alhay=new TextEditingController();
  TextEditingController _numberOfCildren=new TextEditingController();

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dropdownValue='اختر المحافظة';

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      body: new ListView(
          children: <Widget>[

            new Container(
              alignment: Alignment.center,
              height: 100,
              color: new Color(0xffff006064),
              child: new Text('اضافة عائلة محتاجة',style: new TextStyle(fontSize: 30,color: Colors.white),),
            ),

            new Container(
              child:new Container(
                padding: EdgeInsets.all(30),
                child: new Column(
                  children: <Widget>[



                    new Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        controller: _nameOfFather,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(labelText: 'الاسم',),

                      ),
                    ),

                    new Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _numberOfCildren,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(labelText: 'عدد الاطفال'),

                      ),
                    ),
                    new Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        controller: _phonenumber,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(labelText: 'رقم هاتف'),

                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 10)),

                    new Card(
                      elevation: 5,
                      child:  new Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: DropDown(),
                      ),

                    ),


                    new Directionality(
                      textDirection: TextDirection.rtl,
                      child:  new TextField(
                        controller: _city,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(labelText: 'القضاء'),

                      ),
                    ),

                    new Directionality(
                      textDirection: TextDirection.rtl,
                      child: new TextField(
                        controller: _alhay,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(labelText: 'الحي'),

                      ),
                    ),



                    new Directionality(
                      textDirection: TextDirection.rtl,
                      child:     new TextField(
                        controller: _address,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(labelText: 'اقرب نقطة دالة'),

                      ),

                    ),


                    new Padding(padding: EdgeInsets.only(top: 20)),

                    new RaisedButton(onPressed: (){

                      getMyLocation();
                    },
                      elevation: 5,
                      color: Color(0xffff006064),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10)
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text('موقعي على الخريطة',style: new TextStyle(fontSize: 18,color: Colors.white),),
                          new Padding(padding: EdgeInsets.only(left: 30)),

                          new Icon(Icons.location_on,color: Colors.white,)
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



                    new Padding(padding: EdgeInsets.only(top: 10)),



                    new RaisedButton(onPressed: ()async{

                      pr = new ProgressDialog(
                          context, type: ProgressDialogType.Normal);
                      pr.update(
                          progressWidget: new Text('الرجاء الانتظار'));
                      pr.show();

                      insertDataInAll().then((_){
                        insertDataInUserPage();
                        pr.hide();

                      });

                    },
                      elevation: 5,
                      color: new Color(0xffff006064),
                      shape: RoundedRectangleBorder(
                          borderRadius:new BorderRadius.circular(10)),

                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          new Text('حفظ البيانات',style: new TextStyle(fontSize: 18,color: Colors.white),),

                        ],
                      ),
                    ),

                  ],
                ),
              )

            ),



          ]
        ),

    );
  }


  Future<String> loaduid() async {
    final pref = await SharedPreferences.getInstance();
    final key = 'uid';
    final value = pref.getString(key);
    print('token : $value');

    return value;
  }


  Future insertDataInAll()async{

    final PeopleRefrance = FirebaseDatabase.instance.reference().child('Users').child('People');

    idForall = PeopleRefrance.push().key;


    PeopleRefrance.child(idForall).set({
      'id': idForall,
      'nameOfFather': _nameOfFather.text,
      'addres': _address.text,
      'phoneNumber': _phonenumber.text,
      'number_of_chiledren' : _numberOfCildren.text,
      'locationaltitude':locationaltitude,
      'locationlongitude': locationlongitude,
      'muhafada': dropdownValue,
      'city': _city.text,
      'alhay': _alhay.text,
    });


  }

   insertDataInUserPage()async{

    final pref = await SharedPreferences.getInstance();
    final key = 'uid';
    final id = pref.getString(key);
    final PeopleRefrance = FirebaseDatabase.instance.reference().child('Users').child('userProfile').child('People');

    PeopleRefrance.child(id).child(idForall).set({
      'id': idForall,
      'nameOfFather': _nameOfFather.text,
      'addres': _address.text,
      'phoneNumber': _phonenumber.text,
      'number_of_chiledren' : _numberOfCildren.text,
      'locationaltitude':locationaltitude,
      'locationlongitude': locationlongitude,
      'muhafada': dropdownValue,
      'city': _city.text,
      'alhay': _alhay.text,
    }).then((_) {
      Navigator.of(context).pushReplacementNamed('/HomePage');
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
