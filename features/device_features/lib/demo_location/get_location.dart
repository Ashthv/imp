import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/foundation/button/borderlined_button.dart';
import 'package:tcs_dff_design_system/utils/button_utils.dart';
import 'package:tcs_dff_device_feature/location/location_details.dart';
import 'package:tcs_dff_device_feature/location/user_location.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({
    super.key,
  });

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  final userLocation = UserLocation();
  LocationDetails? locationDetails;

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              BorderlinedButton(
                buttonType: ButtonVariants.normal,
                caption: 'Get Location',
                onPressed: () async {
                  final locationCoordinates =
                      await userLocation.getUserLocation();
                  setState(() {
                    locationDetails = locationCoordinates;
                  });
                },
              ),
              Text('Latitude is: ${locationDetails?.latitude}'),
              Text('Longitude is: ${locationDetails?.longitude}'),
              Text('country is: ${locationDetails?.country}'),
              Text('state is: ${locationDetails?.state}'),
              Text('city is: ${locationDetails?.city}'),
              Text('areaCode is: ${locationDetails?.areaCode}'),
            ],
          ),
        ),
      );
}
