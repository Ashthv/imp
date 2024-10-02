abstract interface class DeviceInformationPlugin {
  Future<DeviceBasicInfo> getAndroidOsDetails();
  Future<DeviceBasicInfo> getIosOsDetails();
  Future<DeviceBasicInfo?> getOsVersion();
}

class DeviceBasicInfo {
  final String os;
  final String version;
  final String sdkVersion;
  final String model;
  final String manufacturer;

  DeviceBasicInfo({
    required this.os,
    required this.version,
    required this.sdkVersion,
    required this.model,
    required this.manufacturer,
  });

  static DeviceBasicInfo fromJson(final Map<String, dynamic> json) =>
      DeviceBasicInfo(
        os: json['os'] as String,
        version: json['version'] as String,
        sdkVersion: json['sdkVersion'] as String,
        model: json['model'] as String,
        manufacturer: json['manufacturer'] as String,
      );

  Map<String, dynamic> toJson() => {
        'os': os,
        'version': version,
        'sdkVersion': sdkVersion,
        'model': model,
        'manufacturer': manufacturer,
      };
}
