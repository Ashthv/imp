// ignore_for_file: unawaited_futures

import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:tcs_dff_storage/hive_storage_plugin.dart';

import 'employee_skill.dart';

void main() {
  late HiveStoragePlugin hiveStorage;

  setUp(() {
    hiveStorage = HiveStoragePlugin(
      initFunction: () async {
        Hive.init('.cache');
      },
    );
  });

  tearDownAll(() {
    Directory('.cache').deleteSync(recursive: true);
  });

  test('Set and get data from the Storage', () async {
    const dataToStore = 'FirstName LastName';
    hiveStorage.setItem<String>(
      collectionName: 'testData',
      key: '123456',
      item: dataToStore,
    );
    await hiveStorage.closeCollection<String>(collectionName: 'testData');
    final dataFromStore = await hiveStorage.getItem<String>(
      collectionName: 'testData',
      key: '123456',
    );
    expect(dataToStore, dataFromStore);
    await hiveStorage.clearCollection<String>(collectionName: 'testData');
    await hiveStorage.closeCollection<String>(collectionName: 'testData');
  });

  test('get all the items from the storage', () async {
    var employeeSkill = EmployeeSkill('999', 'Employee Test', 'Flutter');
    await hiveStorage.setItem<String>(
      collectionName: 'employeeSkillData',
      key: '999',
      item: jsonEncode(employeeSkill.toJson()),
    );

    employeeSkill = EmployeeSkill('1000', 'Employee Test1', 'Angular');
    await hiveStorage.setItem<String>(
      collectionName: 'employeeSkillData',
      key: '1000',
      item: jsonEncode(employeeSkill.toJson()),
    );

    final data = await hiveStorage.getAllItems<String>(
      collectionName: 'employeeSkillData',
      keys: ['999', '1000'],
    );

    expect(
      EmployeeSkill.fromJson(
        jsonDecode(data['1000']!) as Map<String, dynamic>,
      ).skill,
      employeeSkill.skill,
    );
    expect(data.length, 2);
    await hiveStorage.clearCollection<String>(
      collectionName: 'employeeSkillData',
    );
    await hiveStorage.closeCollection<String>(
      collectionName: 'employeeSkillData',
    );
  });

  test('delete Item from storage', () async {
    await hiveStorage.setItem<String>(
      collectionName: 'skills',
      key: 'skillName',
      item: 'android',
    );
    await hiveStorage.deleteItem<String>(
      collectionName: 'skills',
      key: 'skillName',
    );
    final data = await hiveStorage.getItem<String>(
      collectionName: 'skills',
      key: 'skillName',
    );
    expect(data, null);

    await hiveStorage.clearCollection<String>(collectionName: 'skills');
    await hiveStorage.closeCollection<String>(collectionName: 'skills');

    // test else condition when collection is closed
    await hiveStorage.setItem<String>(
      collectionName: 'skills',
      key: 'skillName',
      item: 'android',
    );
    await hiveStorage.deleteItem<String>(
      collectionName: 'skills',
      key: 'skillName',
    );
    final d = await hiveStorage.getItem<String>(
      collectionName: 'skills',
      key: 'skillName',
    );
    expect(d, null);
    await hiveStorage.clearCollection<String>(collectionName: 'skills');
    await hiveStorage.closeCollection<String>(collectionName: 'skills');
  });

  test('delete all items', () async {
    var dataToStore = 'FirstName LastName';
    hiveStorage.setItem<String>(
      collectionName: 'testData',
      key: '123456',
      item: dataToStore,
    );

    dataToStore = 'TestName LastName';
    hiveStorage.setItem<String>(
      collectionName: 'testData',
      key: 'abcdef',
      item: dataToStore,
    );
    await hiveStorage.deleteAllItems<String>(
      collectionName: 'testData',
      keys: ['123456', 'abcdef'],
    );

    final data = await hiveStorage.getAllItems<String>(
      collectionName: 'testData',
      keys: ['123456', 'abcdef'],
    );
    expect(data['123456'], null);
    expect(data['abcdef'], null);
    await hiveStorage.clearCollection<String>(collectionName: 'testData');
    await hiveStorage.closeCollection<String>(collectionName: 'testData');
  });

  test('clear collection', () async {
    hiveStorage
      ..setItem<String>(
        collectionName: 'skills',
        key: '123',
        item: 'Flutter',
      )
      ..setItem<String>(
        collectionName: 'skills',
        key: '124',
        item: 'Android',
      )
      ..setItem<String>(
        collectionName: 'skills',
        key: '125',
        item: 'React Native',
      );
    final result = await hiveStorage.clearCollection<String>(
      collectionName: 'skills',
    );
    expect(result, 3);
    await hiveStorage.closeCollection<String>(
      collectionName: 'skills',
    );
  });
}
