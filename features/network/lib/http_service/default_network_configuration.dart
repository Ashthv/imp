import 'package:tcs_dff_network/http_network_configuration.dart';

class DefaultNetworkConfiguration {
  static HTTPNetworkConfiguration networkConfiguration =
      HTTPNetworkConfiguration(
    isDebugBuild: true,
    showLogs: true,
    refreshTokenURL: '',
    clientId: '',
    clientSecret: '',
    defaultHeaders: {
      'Content-Type': 'application/json',
      'channelkey': 'sbiyonokey',
      'datatype': 'application/json',
    },
    rsaPublicKey:
        'MF0wDQYJKoZIhvcNAQEBBQADTAAwSQJCMAEXpIGJncqu+Nl9NQPVvrQMwsK/5LRC1svomZgl4NlyMnazBmEN7nS16Y7DGgAAcw9yiBardKsH1g8+5KTXXSkzAgMBAAE=',
    sessionTokenUrl:
        'http://10.10.213.33:91/SBIYONOGateway/GATEWAY/SERVICES/security/generateSessionToken',
  );
}
