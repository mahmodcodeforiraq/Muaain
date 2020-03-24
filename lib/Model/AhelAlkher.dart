import 'package:firebase_database/firebase_database.dart';

class AhelAlkher {
  String _id;
  String _name;
  String _address;
  String _locationaltitude;
  String _locationlongitude;
  String _muhafada;
  String _city;
  String _alhay;
  String _phonenumber;


  AhelAlkher(this._id, this._name, this._address,
      this._locationaltitude,this._locationlongitude,
      this._muhafada, this._city, this._phonenumber,this._alhay);

  AhelAlkher.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._address = obj['addres'];
    this._phonenumber = obj['phoneNumber'];
    this._locationaltitude = obj['locationaltitude'];
    this._locationlongitude = obj['locationlongitude'];
    this._muhafada = obj['muhafada'];
    this._city = obj['city'];
    this._alhay = obj['alhay'];


  }

  String get id => _id;
  String get name => _name;
  String get address => _address;
  String get phonenumber => _phonenumber;
  String get locationaltitude => _locationaltitude;
  String get locationlongitude => _locationlongitude;
  String get muhafada => _muhafada;
  String get city => _city;
  String get alhay => _alhay;




  AhelAlkher.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.value['id'];
    _name = snapshot.value['name'];
    _address = snapshot.value['addres'];
    _phonenumber = snapshot.value['phoneNumber'];
    _locationaltitude = snapshot.value['locationaltitude'];
    _locationlongitude = snapshot.value['locationlongitude'];
    _muhafada = snapshot.value['muhafada'];
    _city = snapshot.value['city'];
    _alhay = snapshot.value['alhay'];

  }
}
