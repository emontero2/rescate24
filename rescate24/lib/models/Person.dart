import 'dart:typed_data';

class Person {
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
}
