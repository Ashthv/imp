class SIMDetail {
  String simSlotIndex = '';
  String subscriptionID = '';
  String? simDisplayName;
  String? carrierName;

  SIMDetail({
    required this.simSlotIndex,
    required this.subscriptionID,
    this.simDisplayName,
    this.carrierName,
  });

  static SIMDetail fromJson(final Map<String, dynamic> json) => SIMDetail(
        simSlotIndex: json['simSlotIndex'] as String,
        subscriptionID: json['subscriptionID'] as String,
        simDisplayName: json['displayName'] as String?,
        carrierName: json['carrierName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'simSlotIndex': simSlotIndex,
        'subscriptionID': subscriptionID,
        'displayName': simDisplayName,
        'carrierName': carrierName,
      };
}
