// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(final Map<String, dynamic> json) => Error(
      title: json['title'] as String,
      description: json['description'] as String,
      userMessage: json['userMessage'] as String?,
      technicalMessage: json['technicalMessage'] as String?,
      errorCode: json['errorCode'] as String?,
    );

Map<String, dynamic> _$ErrorToJson(final Error instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'userMessage': instance.userMessage,
      'technicalMessage': instance.technicalMessage,
      'errorCode': instance.errorCode,
    };
