import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcs_dff_storage/shared_preference_storage.dart';

void main() {
  late SharedPreferenceStorage sharedPreferenceStorage;
  setUp(
    () async {
      sharedPreferenceStorage = SharedPreferenceStorage();
      final values = <String, int>{'counter': 1};
      SharedPreferences.setMockInitialValues(values);
      final securedHashValue = <String, String>{
        'securedHash': '2434ds@11%23@*&',
      };
      FlutterSecureStorage.setMockInitialValues(securedHashValue);
    },
  );

  test('Test Shared Preference', () async {
    await sharedPreferenceStorage.init();
    final value = sharedPreferenceStorage.getIntValue(key: 'counter');
    expect(1, value);

    sharedPreferenceStorage.setIntValue(key: 'counter', value: value! + 1);
    expect(sharedPreferenceStorage.getIntValue(key: 'counter'), 2);

    sharedPreferenceStorage.setBoolValue(key: 'flag', value: true);
    expect(sharedPreferenceStorage.getBoolValue(key: 'flag'), true);

    sharedPreferenceStorage.setStringValue(key: 'name', value: 'abc xyz');
    expect(sharedPreferenceStorage.getStringValue(key: 'namee'), null);

    sharedPreferenceStorage.setDoubleValue(key: 'pi', value: 2.14);
    expect(sharedPreferenceStorage.getDoubleValue(key: 'pi'), 2.14);

    await sharedPreferenceStorage.deleteData(key: 'pi');
    expect(sharedPreferenceStorage.getDoubleValue(key: 'pi'), isNull);

    final result = await sharedPreferenceStorage.clearData();
    expect(result, true);
    expect(sharedPreferenceStorage.getIntValue(key: 'counter'), isNull);
  });

  test('Test Secured Shared Preference', () async {
    await sharedPreferenceStorage.init();
    await sharedPreferenceStorage.setSecuredStringValue(
      key: 'securedId',
      value: '10',
    );
    expect(
      await sharedPreferenceStorage.getSecuredStringValue(key: 'securedId'),
      '10',
    );

    await sharedPreferenceStorage.setSecuredIntValue(
      key: 'securedId',
      value: 10,
    );
    expect(
      await sharedPreferenceStorage.getSecuredIntValue(key: 'securedId'),
      10,
    );

    await sharedPreferenceStorage.setSecuredBoolValue(
      key: 'securedFlag',
      value: false,
    );

    expect(
      await sharedPreferenceStorage.getSecuredBoolValue(key: 'securedFlagg'),
      null,
    );

    await sharedPreferenceStorage.setSecuredDoubleValue(
      key: 'securedDouble',
      value: 2.14,
    );
    expect(
      await sharedPreferenceStorage.getSecuredDoubleValue(
        key: 'securedDouble',
      ),
      2.14,
    );

    await sharedPreferenceStorage.deleteSecuredData(key: 'securedDouble');
    expect(
      await sharedPreferenceStorage.getSecuredDoubleValue(key: 'securedDouble'),
      isNull,
    );

    await sharedPreferenceStorage.clearSecuredData();
    expect(
      await sharedPreferenceStorage.getSecuredIntValue(key: 'securedId'),
      isNull,
    );
  });
}
