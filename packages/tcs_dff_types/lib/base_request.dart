typedef RequestBody = Object;

class BaseRequest {
  RequestHeader? headers;
  RequestBody body;

  BaseRequest({
    this.headers,
    required this.body,
  });

  Map<String, dynamic> toJson() => {
        'headers': headers!.toJson(),
        'body': body,
      };
}

class RequestHeader {
  LocationInfo? locationInfo;
  DeviceDetails? deviceInfo;
  EnvMetaInfo? envMetaInfo;
  String? reqNo;

  RequestHeader({
    this.locationInfo,
    this.deviceInfo,
    this.envMetaInfo,
    this.reqNo,
  });

  Map<String, dynamic> toJson() => {
        'locationInfo': locationInfo!.toJson(),
        'deviceInfo': deviceInfo!.toJson(),
        'envMetaInfo': envMetaInfo!.toJson(),
        'reqNo': reqNo,
      };
}

class DeviceDetails {
  final String deviceId;
  final String os;
  final String osVersion;
  final String simSlot;

  DeviceDetails({
    required this.deviceId,
    required this.os,
    required this.osVersion,
    required this.simSlot,
  });

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'os': os,
        'osVersion': osVersion,
        'simSlot': simSlot,
      };
}

class LocationInfo {
  final double? latitude;
  final double? longitude;
  final String? country;
  final String? city;
  final String? state;
  final String? areaCode;

  LocationInfo({
    this.latitude,
    this.longitude,
    this.country,
    this.city,
    this.state,
    this.areaCode,
  });

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'country': country,
        'city': city,
        'state': state,
        'areaCode': areaCode,
      };
}

class EnvMetaInfo {
  EnvMetaInfo();
  Map<String, dynamic> toJson() => {};
}
