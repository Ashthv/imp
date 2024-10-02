import 'package:faker/faker.dart';

class Person {
  late int id;
  late String name;

  Person() {
    name = Faker().person.name();
    id = Faker().randomGenerator.integer(100);
  }

  int getId() => id;

  String getName() => name;

  void setId(int id) {
    id = id;
  }

  void setName(String name) {
    name = name;
  }

  @override
  String toString() => '''id = $id
    name = $name''';
}
