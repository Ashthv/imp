class HTTPNetworkConfiguration {
  final String? refreshTokenURL;
  final String? clientSecret;
  final String? clientId;
  final Map<String, String> defaultHeaders;
  final Duration timeOut;
  bool enableEncryption;
  final String rsaPublicKey;
  final String sessionTokenUrl;
  bool showLogs;
  bool isDebugBuild;
  bool stubEnabled;

  HTTPNetworkConfiguration({
    this.refreshTokenURL,
    this.clientSecret,
    this.clientId,
    this.timeOut = const Duration(seconds: 30),
    required this.defaultHeaders,
    this.enableEncryption = false,
    required this.rsaPublicKey,
    required this.sessionTokenUrl,
    this.showLogs = false,
    this.isDebugBuild = false,
    this.stubEnabled = false,
  });
}
