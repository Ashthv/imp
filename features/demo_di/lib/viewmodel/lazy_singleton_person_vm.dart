import '../model/person.dart';

class LazyStingletonPersonVM {
  Person? person;

  Future<Person> fetchPerson() async {
    person = await Future.delayed(const Duration(milliseconds: 1000))
        .then((final onValue) => Person());
    return person!;
  }
}
