// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specification _$SpecificationFromJson(Map<String, dynamic> json) =>
    Specification(
      featureSpec:
          FeatureSpec.fromJson(json['featureSpec'] as Map<String, dynamic>),
      apiSpec: json['apiSpec'] == null
          ? null
          : APISpec.fromJson(json['apiSpec'] as Map<String, dynamic>),
      storeSpec: json['storeSpec'] == null
          ? null
          : StoreSpec.fromJson(json['storeSpec'] as Map<String, dynamic>),
      viewSpec: json['viewSpec'] == null
          ? null
          : ViewSpec.fromJson(json['viewSpec'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpecificationToJson(Specification instance) =>
    <String, dynamic>{
      'apiSpec': instance.apiSpec,
      'storeSpec': instance.storeSpec,
      'featureSpec': instance.featureSpec,
      'viewSpec': instance.viewSpec,
    };

FeatureSpec _$FeatureSpecFromJson(Map<String, dynamic> json) => FeatureSpec(
      featureName: json['featureName'] as String,
      outputPath: json['outputPath'] as String,
    );

Map<String, dynamic> _$FeatureSpecToJson(FeatureSpec instance) =>
    <String, dynamic>{
      'featureName': instance.featureName,
      'outputPath': instance.outputPath,
    };

ViewSpec _$ViewSpecFromJson(Map<String, dynamic> json) => ViewSpec(
      className: json['className'] as String,
      stateLess: json['stateLess'] as bool,
    );

Map<String, dynamic> _$ViewSpecToJson(ViewSpec instance) => <String, dynamic>{
      'className': instance.className,
      'stateLess': instance.stateLess,
    };

APISpec _$APISpecFromJson(Map<String, dynamic> json) => APISpec(
      className: json['className'] as String,
      apiFunction:
          ApiFunction.fromJson(json['apiFunction'] as Map<String, dynamic>),
      url: json['url'] as String,
    );

Map<String, dynamic> _$APISpecToJson(APISpec instance) => <String, dynamic>{
      'className': instance.className,
      'apiFunction': instance.apiFunction,
      'url': instance.url,
    };

StoreSpec _$StoreSpecFromJson(Map<String, dynamic> json) => StoreSpec(
      className: json['className'] as String,
      storeFunction:
          StoreFunction.fromJson(json['storeFunction'] as Map<String, dynamic>),
      apiFunctionCall: json['apiFunctionCall'] as String?,
    );

Map<String, dynamic> _$StoreSpecToJson(StoreSpec instance) => <String, dynamic>{
      'className': instance.className,
      'storeFunction': instance.storeFunction,
      'apiFunctionCall': instance.apiFunctionCall,
    };

StoreFunction _$StoreFunctionFromJson(Map<String, dynamic> json) =>
    StoreFunction(
      json['functionName'] as String,
      (json['observers'] as List<dynamic>)
          .map((e) => KeyValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['functionParams'] as List<dynamic>?)
          ?.map((e) => KeyValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreFunctionToJson(StoreFunction instance) =>
    <String, dynamic>{
      'functionName': instance.functionName,
      'observers': instance.observers,
      'functionParams': instance.functionParams,
    };

ApiFunction _$ApiFunctionFromJson(Map<String, dynamic> json) => ApiFunction(
      json['functionName'] as String,
      (json['functionParams'] as List<dynamic>?)
          ?.map((e) => KeyValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['returnObject'] as Object,
    );

Map<String, dynamic> _$ApiFunctionToJson(ApiFunction instance) =>
    <String, dynamic>{
      'functionName': instance.functionName,
      'functionParams': instance.functionParams,
      'returnObject': instance.returnObject,
    };

KeyValue _$KeyValueFromJson(Map<String, dynamic> json) => KeyValue(
      type: json['type'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$KeyValueToJson(KeyValue instance) => <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
    };
