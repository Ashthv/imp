import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';

import '../viewmodel/http_viewmodel.dart';

class HttpMethodsScreen extends StatelessWidget {
  final requestTypes = [
    'GET',
    'POST',
    'PUT',
    'DELETE',
    'HEAD',
    'SEND',
    'LOGIN_TEST',
    'LOGOUT_TEST',
    'RESPONSE',
  ];
  HttpMethodsScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final httpVieWModel = Provider.of<HTTPViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: requestTypes.length,
        itemBuilder: (final context, final index) => Card(
          child: ListTile(
            title: requestTypes[index] == 'RESPONSE'
                ? httpVieWModel.showIndicator
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      )
                    : Text(
                        httpVieWModel.apiResult.result != null
                            ? '${httpVieWModel.apiResult.result}'
                            : 'API Response',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.theme.appColor.greyFullBlack10,
                        ),
                      )
                : Text(
                    'API Request ${requestTypes[index]}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.theme.appColor.greyFullBlack10,
                    ),
                  ),
            onTap: () {
              if (requestTypes[index] != 'RESPONSE') {
                httpVieWModel.apiCall(requestTypes[index]);
              }
            },
          ),
        ),
      ),
    );
  }
}
