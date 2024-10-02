import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tcs_dff_types/platform.dart';

import '../model/profile.dart';
import '../viewmodel/profile_view_model.dart';
import 'create_profile_screen.dart';
import 'widget_profile_list_item.dart';

class ProfileListScreen extends StatefulWidget {
  const ProfileListScreen({super.key});

  @override
  State<ProfileListScreen> createState() => _ProfileListScreenState();
}

class _ProfileListScreenState extends State<ProfileListScreen> {
  Map<String, String?> _profilesMap = {};
  late ProfileViewModel profileViewModel;

  @override
  void initState() {
    _profilesMap = {};
    profileViewModel =
        dff.di.get<ProfileViewModel>(instanceName: 'profileNameViewModel');
    if (profileViewModel.getAllProfileKeys().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((final _) => getProfiles());
    }
    super.initState();
  }

//Method to get profile data from the storage
  Future<void> getProfiles() async {
    _profilesMap = await dff.storage.getAllItems<String>(
      collectionName: 'profile',
      keys: profileViewModel.getAllProfileKeys(),
    );
    setState(() {});
  }

  @override
  Widget build(final BuildContext context) => ListView.builder(
        itemCount: _profilesMap.length,
        itemBuilder: (final context, final index) => InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (final context) => CreateProfileScreen(
                  profile: Profile.fromJson(
                    json.decode(
                      _profilesMap[profileViewModel.getProfileKey(index)]!,
                    ) as Map<String, dynamic>,
                  ),
                ),
              ),
            );
            unawaited(getProfiles());
          },
          child: WidgetProfileListItem(
            profile: Profile.fromJson(
              json.decode(
                _profilesMap[profileViewModel.getProfileKey(index)]!,
              ) as Map<String, dynamic>,
            ),
            onDeletePress: _onDeleteItemPress,
          ),
        ),
      );

//Method to delete item
  void _onDeleteItemPress(final String key) {
    profileViewModel.deleteProfileKey(key);
    _profilesMap.remove(key);
    dff.storage.deleteItem<String>(collectionName: 'profile', key: key);
    setState(() {});
  }
}
