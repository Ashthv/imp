import '../model/person.dart';

class FactoryPersonVM {
  late final Person factoryPerson;

  FactoryPersonVM() {
    factoryPerson = Person();
  }

  String getNameFromVM() => factoryPerson.getName();

  int getIdFromVM() => factoryPerson.getId();
}
