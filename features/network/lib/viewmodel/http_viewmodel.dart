import 'package:flutter/material.dart';
import '../http_service/http_service.dart';
import '../model/api_data.dart';

class HTTPViewModel extends ChangeNotifier {
  final APIData apiResult = APIData();

  bool showIndicator = false;
  final _httpService = HTTPService();

  Future<void> apiCall(final String requestType) async {
    showIndicator = true;
    notifyListeners();
    apiResult.result = await _httpService.httpCall(requestType) as String;
    showIndicator = false;
    notifyListeners();
  }
}
