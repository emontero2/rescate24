import 'dart:ffi';
import 'dart:typed_data';

class Person {
  Person.empty();
  Person(this._name, this._lastName, this._docNumber, this._gnere,
      this._liveness, this._portrait, this._birthDay);

  late String _name;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  late String _lastName;

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  late String _birthDay;

  String get birthDay => _birthDay;

  set birthDay(String value) {
    _birthDay = value;
  }

  late Uint8List? _portrait;

  Uint8List? get portrait => _portrait;

  set portrait(Uint8List? value) {
    _portrait = value;
  }

  late String _gnere;

  String get gnere => _gnere;

  set gnere(String value) {
    _gnere = value;
  }

  late String _docNumber;

  String get docNumber => _docNumber;

  set docNumber(String value) {
    _docNumber = value;
  }

  bool _liveness = false;
  bool get liveness => this._liveness;

  set liveness(bool value) => this._liveness = value;
  late String _municipe;

  String get municipe => _municipe;

  set municipe(String value) {
    _municipe = value;
  }

  late String _province;
  late String _direction;
  late String _phoneNumber;
  late String _email;
  get province => _province;

  set province(value) => _province = value;

  get direction => _direction;

  set direction(value) => _direction = value;

  get phoneNumber => _phoneNumber;

  set phoneNumber(value) => _phoneNumber = value;

  get email => _email;

  set email(value) => _email = value;

  static List<Person> generatePerson() {
    return List.generate(
        5,
        (index) => Person("Irlanda Montero Figuereo", "Mansueta",
            "402-239302-3", "M", false, null, "29-19-2023"));
  }
}
