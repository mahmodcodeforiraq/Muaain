import 'package:firebase_database/firebase_database.dart';

class People {
  String _id;
  String _nameOfFather;
  String _number_of_chiledren;
  String _address;
  String _locationaltitude;
  String _locationlongitude;
  String _muhafada;
  String _city;
  String _alhay;
  String _phonenumber;


  People(this._id, this._nameOfFather, this._number_of_chiledren, this._address,
      this._locationaltitude,this._locationlongitude,
      this._muhafada, this._city, this._phonenumber,this._alhay);

  People.map(dynamic obj) {
    this._id = obj['id'];
    this._nameOfFather = obj['nameOfFather'];
    this._number_of_chiledren = obj['number_of_chiledren'];
    this._address = obj['addres'];
    this._phonenumber = obj['phoneNumber'];
    this._locationaltitude = obj['locationaltitude'];
    this._locationlongitude = obj['locationlongitude'];
    this._muhafada = obj['muhafada'];
    this._city = obj['city'];
    this._alhay = obj['alhay'];


  }

  String get id => _id;
  String get nameOfFather => _nameOfFather;
  String get number_of_chiledren => _number_of_chiledren;
  String get address => _address;
  String get phonenumber => _phonenumber;
  String get locationaltitude => _locationaltitude;
  String get locationlongitude => _locationlongitude;
  String get muhafada => _muhafada;
  String get city => _city;
  String get alhay => _alhay;


  People.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.value['id'];
    _nameOfFather = snapshot.value['nameOfFather'];
    _number_of_chiledren = snapshot.value['number_of_chiledren'];
    _address = snapshot.value['addres'];
    _phonenumber = snapshot.value['phoneNumber'];
    _locationaltitude = snapshot.value['locationaltitude'];
    _locationlongitude = snapshot.value['locationlongitude'];
    _muhafada = snapshot.value['muhafada'];
    _city = snapshot.value['city'];
    _alhay = snapshot.value['alhay'];

  }
}
