import 'package:flutter/cupertino.dart';
import 'package:rescate24/models/Person.dart';

class PersonModel extends ChangeNotifier {
  final List<Person> _persons = [];

  List<Person> get person => _persons;

  void add(Person person) {
    _persons.add(person);

    notifyListeners();
  }

  void removeAll() {
    _persons.clear();

    notifyListeners();
  }
}
