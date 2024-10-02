class LocationDetails {
  late double latitude;
  late double longitude;
  late String? city;
  late String? country;
  late String? areaCode;
  late String? state;

  LocationDetails({
    required this.latitude,
    required this.longitude,
    this.city,
    this.country,
    this.areaCode,
    this.state,
  });

  static LocationDetails fromJson(final Map<String, dynamic> json) =>
      LocationDetails(
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        city: json['city'] != null ? json['city'] as String : '',
        country: json['country'] != null ? json['country'] as String : '',
        areaCode: json['areaCode'] != null ? json['areaCode'] as String : '',
        state: json['state'] != null ? json['state'] as String : '',
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'areaCode': areaCode,
        'city': city,
        'country': country,
        'state': state,
      };
}
