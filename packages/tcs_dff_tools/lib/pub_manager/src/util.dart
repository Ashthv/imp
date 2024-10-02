String dumpYaml(final Map yamlMap, {final int indent = 0}) {
  var yamlString = '';

  yamlMap.forEach((final key, final value) {
    if (value is Map) {
      yamlString += '${' ' * indent}$key:\n';

      yamlString += dumpYaml(value, indent: indent + 2);
    } else if (value is String) {
      yamlString += '${' ' * indent}$key:';

      if (value.contains(RegExp(r'[<=>]'))) {
        yamlString += '${' '}\'$value\'\n';
      } else {
        yamlString += '${' '}$value\n';
      }
    } else {
      yamlString += '${' ' * indent}$key: ${value ?? ""}\n';
    }
  });

  return yamlString;
}
