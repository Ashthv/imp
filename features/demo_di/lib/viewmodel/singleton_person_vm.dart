import '../model/person.dart';

class SingletonPersonVM {
  late final Person singletonPerson;
  SingletonPersonVM() {
    singletonPerson = Person();
  }

  String getNameFromVM() => singletonPerson.getName();

  int getIdFromVM() => singletonPerson.getId();

  void setNameFromVM(final String name) {
    singletonPerson.setName(name);
  }

  void setIdFromVM(final int id) {
    singletonPerson.setId(id);
  }
}
