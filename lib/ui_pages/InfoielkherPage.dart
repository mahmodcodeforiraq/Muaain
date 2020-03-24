
import 'package:ail_alkher/Model/AhelAlkher.dart';
import 'package:ail_alkher/Model/People.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoAhelkherPage extends StatefulWidget{
  final AhelAlkher ahelAlkher ;
  InfoAhelkherPage(this.ahelAlkher);
  @override
  State<StatefulWidget> createState() {

    return new StateInfoAhelkherPage();
  }

}
final doctorRefrance = FirebaseDatabase.instance.reference().child('Users').child('Muaain');

class StateInfoAhelkherPage extends State<InfoAhelkherPage>{
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: new Color(0xffff006064),
        title: new Text('معلومات المُعين',style: TextStyle(fontSize: 24),),

        centerTitle: true,
      ),

      body: new Container(
          alignment:Alignment.center,
          child: new ListView(
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 50)),

              new Container(
                padding: EdgeInsets.all(30),
                child: new RaisedButton(
                  onPressed: (){
                  MapUtils.openMap(widget.ahelAlkher.locationaltitude ,widget.ahelAlkher.locationlongitude);
                },
                  color:new Color(0xffff006064),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('معرفه العنوان على الخريطة',style: new TextStyle(fontSize: 20,color: Colors.white),),
                      new Padding(padding: EdgeInsets.only(left: 20)),

                      new Icon(Icons.location_on,color: Colors.white,)
                    ],
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10)
                  ),
                ),

              ),
              new Column(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(top: 30)),

                  new Container(
                    padding: EdgeInsets.all(20),
                    child: new  Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: const Color(0xff888888).withOpacity(0.17),
                        border: Border.all(width: 4,color: const Color(0xffffffff),),
                        borderRadius: BorderRadius.circular(22),

                      ),

                      child: Column(


                        children: <Widget>[
                          new Container(
                            alignment:Alignment.topLeft,
                            
                            child: new FloatingActionButton(onPressed: (){ launch('tel://${widget.ahelAlkher.phonenumber}'); },
                              backgroundColor: new Color(0xffff006064),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(Icons.call),
                                ],
                              ),
                            ),

                          ),

                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Padding(padding: EdgeInsets.only(top: 50)),

                              new Text('الاسم : ${widget.ahelAlkher.name}',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 18),),
                              new Text('رقم هاتف الحجز : ${widget.ahelAlkher.phonenumber}',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 18),),

                              new Text('العنوان : ${widget.ahelAlkher.address}',textDirection: TextDirection.rtl,style: TextStyle(fontSize: 18),),
                              new Text('المحافظة : ${widget.ahelAlkher.muhafada}',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 18),),
                              new Text('المدينة : ${widget.ahelAlkher.city}',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 18),),
                              new Text("الحي: ${widget.ahelAlkher.alhay}",textDirection: TextDirection.ltr,style: TextStyle(fontSize: 18),),


                            ],
                          )
                        ],

                      ),
                    ),

                  ),


                ],

              ),


            ],
          )

      ),
    );
  }

}


class MapUtils {

  MapUtils._();

  static Future<void> openMap(String latitude, String longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
