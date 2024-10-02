
import 'package:flutter_test/flutter_test.dart';

import 'package:tcs_dff_tools/codegen/util/util.dart';

void main() {
  // test('API spec file should be created', () async {
  //   gen.main(['./input/default_specification']);
  // });

  test('Convert capital case to snakecase', () async {
    const temp = 'CapitalString';
    expect(temp.toSnakeCase(), 'capital_string');
  });
}
