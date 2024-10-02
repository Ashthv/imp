import 'package:json_annotation/json_annotation.dart';
part 'specification.g.dart';

@JsonSerializable()
class Specification {
  APISpec? apiSpec;
  StoreSpec? storeSpec;
  FeatureSpec featureSpec;
  ViewSpec? viewSpec;
  Specification({
    required this.featureSpec,
    required this.apiSpec,
    required this.storeSpec,
    required this.viewSpec,
  });

  factory Specification.fromJson(final Map<String, dynamic> json) =>
      _$SpecificationFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificationToJson(this);
}

@JsonSerializable()
class FeatureSpec {
  String featureName;
  String outputPath;

  FeatureSpec({
    required this.featureName,
    required this.outputPath,
  });

  factory FeatureSpec.fromJson(final Map<String, dynamic> json) =>
      _$FeatureSpecFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureSpecToJson(this);
}

@JsonSerializable()
class ViewSpec {
  String className;
  bool stateLess;
  ViewSpec({
    required this.className,
    required this.stateLess,
  });

  factory ViewSpec.fromJson(final Map<String, dynamic> json) =>
      _$ViewSpecFromJson(json);
  Map<String, dynamic> toJson() => _$ViewSpecToJson(this);
}

@JsonSerializable()
class APISpec {
  String className;
  ApiFunction apiFunction;
  String url;

  APISpec({
    required this.className,
    required this.apiFunction,
    required this.url,
  });

  factory APISpec.fromJson(final Map<String, dynamic> json) =>
      _$APISpecFromJson(json);
  Map<String, dynamic> toJson() => _$APISpecToJson(this);
}

@JsonSerializable()
class StoreSpec {
  String className;
  StoreFunction storeFunction;
  String? apiFunctionCall;

  StoreSpec({
    required this.className,
    required this.storeFunction,
    this.apiFunctionCall,
  });

  factory StoreSpec.fromJson(final Map<String, dynamic> json) =>
      _$StoreSpecFromJson(json);
  Map<String, dynamic> toJson() => _$StoreSpecToJson(this);
}

@JsonSerializable()
class StoreFunction {
  String functionName;
  List<KeyValue> observers;
  List<KeyValue>? functionParams;
  StoreFunction(this.functionName, this.observers, this.functionParams);

  factory StoreFunction.fromJson(final Map<String, dynamic> json) =>
      _$StoreFunctionFromJson(json);
  Map<String, dynamic> toJson() => _$StoreFunctionToJson(this);
}

@JsonSerializable()
class ApiFunction {
  String functionName;
  List<KeyValue>? functionParams;
  Object returnObject;
  ApiFunction(this.functionName, this.functionParams, this.returnObject);

  factory ApiFunction.fromJson(final Map<String, dynamic> json) =>
      _$ApiFunctionFromJson(json);
  Map<String, dynamic> toJson() => _$ApiFunctionToJson(this);
}

@JsonSerializable()
class KeyValue {
  String type;
  String name;

  KeyValue({
    required this.type,
    required this.name,
  });

  factory KeyValue.fromJson(final Map<String, dynamic> json) =>
      _$KeyValueFromJson(json);
  Map<String, dynamic> toJson() => _$KeyValueToJson(this);
}
