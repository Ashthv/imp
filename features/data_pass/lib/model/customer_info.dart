class CustomerInfo {
  final String? name;
  final String? mobileNo;
  final String? aadhaarNo;
  final String? panNo;

  const CustomerInfo({
    this.name,
    this.mobileNo,
    this.aadhaarNo,
    this.panNo,
  });

  CustomerInfo copyWith({
    final String? name,
    final String? mobileNo,
    final String? aadhaarNo,
    final String? panNo,
  }) =>
      CustomerInfo(
        name: name ?? this.name,
        mobileNo: mobileNo ?? this.mobileNo,
        aadhaarNo: aadhaarNo ?? this.aadhaarNo,
        panNo: panNo ?? this.panNo,
      );

  @override
  String toString() => '''
      CustomerInfo { 
        name: $name, 
        mobileNo: $mobileNo,  
        aadhaarNo: $aadhaarNo, 
        panNo: $panNo,
      }
    ''';
}
