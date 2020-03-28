import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';



String dropdownValue ;

class  AddMuaain extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateAddMuaain();
  }

}

final MuaainRefrance = FirebaseDatabase.instance.reference().child('Users').child('Muaain');

FirebaseAuth myAuth = FirebaseAuth.instance;

String uid;

class StateAddMuaain extends State<AddMuaain>{


  bool _loading;
  double _progressValue;
ProgressDialog pr;


  String  locationaltitude;
  String locationlongitude;


  TextEditingController _name= new TextEditingController();
  TextEditingController _address= new TextEditingController();
  TextEditingController _city= new TextEditingController();
  TextEditingController _phonenumber= new TextEditingController();
  TextEditingController _alhay=new TextEditingController();

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue='اختر المحافظة';
    _loading = false;
    _progressValue = 0.0;


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
              child: new Text('انشاء حساب جديد',style: new TextStyle(fontSize: 30,color: Colors.white),),
            ),

            new Container(
              child:new Container(
                padding: EdgeInsets.all(30),
                child: new Column(
                  children: <Widget>[
                    new TextField(
                      controller: _email,
                      decoration: InputDecoration(labelText: 'البريد الالكتروني'),
                    ),

                    new TextField(
                      keyboardType: TextInputType.visiblePassword,

                      controller: _password,
                      decoration: InputDecoration(labelText: 'كلمة المرور'),
                      obscureText: true,
                    ),





                    new Padding(padding: EdgeInsets.only(top: 30)),

                    new TextField(
                      controller: _name,
                      decoration: InputDecoration(labelText: 'الاسم'),
                    ),

                    new TextField(
                      controller: _address,
                      decoration: InputDecoration(labelText: 'العنوان'),
                    ),


                    new TextField(
                      keyboardType: TextInputType.number,
                      controller: _phonenumber,
                      decoration: InputDecoration(labelText: 'رقم هاتف'),
                    ),


                    new TextField(
                      controller: _city,
                      decoration: InputDecoration(labelText: 'قضاء'),
                    ),
                    new TextField(
                      controller: _alhay,
                      decoration: InputDecoration(labelText: 'الحي'),
                    ),

                    new Container(
                      height: 60,
                      child:  DropDown(),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 40)),

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



                    new RaisedButton(onPressed: (){

                      register()
                          .then((_){

                                pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
                                pr.update(progressWidget: new Text('الرجاء الانتظار'));
                                pr.show();

                        myAuth.signInWithEmailAndPassword(email: _email.text,
                            password: _password.text)

                            .then((_){
                          inputData()

                              .then((_){
                            insertData(uid);
                            pr.hide();

                          });
                        });


                      });
                    },
                      elevation: 5,
                      color: new Color(0xffff006064),
                      shape: RoundedRectangleBorder(
                          borderRadius:new BorderRadius.circular(10)),

                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          new Text('انشاء حساب وحفظ البيانات',style: new TextStyle(fontSize: 18,color: Colors.white),),

                        ],
                      ),
                    ),

                  ],
                ),
              )

            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                new FlatButton(onPressed: (){
                  Navigator.of(context).pushNamed('/Login');
                },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text('سجل دخول',style: TextStyle(fontSize: 20,color: Color(0xffff006064),fontWeight: FontWeight.bold),),
                        new Padding(padding: EdgeInsets.only(left: 10)),
                      ],
                    )
                ),

                new Text(' تمتلك حساب؟',
                    textDirection:TextDirection.ltr ,
                    style: new TextStyle(fontSize: 18,color: Colors.black ,)
                ),


              ],
            ),
            new Padding(padding: EdgeInsets.only(bottom: 20)),


          ]
        ),

    );
  }



  Future register() async{
    myAuth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text).then((_){


    });

  }

  Future insertData(id)async{



     await MuaainRefrance.child(id).set({
        'id': id,
        'name': _name.text,
        'addres': _address.text,
        'phoneNumber': _phonenumber.text,
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

  Future<String> inputData() async {
    final FirebaseUser user = await myAuth.currentUser();
    uid = user.uid;
    // here you write the codes to input the data into firestore

    return uid;
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
