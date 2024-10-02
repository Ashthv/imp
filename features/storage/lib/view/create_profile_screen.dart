import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tcs_dff_types/platform.dart';

import '../model/profile.dart';
import '../storage_main.dart';
import '../viewmodel/profile_view_model.dart';
import 'profile_list_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  final Profile? profile;
  const CreateProfileScreen({
    super.key,
    this.profile,
  });

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  late TextEditingController emailTextController,
      nameTextController,
      contactTextController,
      primarySkillTextController;
  late ProfileViewModel profileViewModel;

  @override
  void initState() {
    initialiseController();
    setUpDiForDiStorage();
    profileViewModel =
        dff.di.get<ProfileViewModel>(instanceName: 'profileNameViewModel');
    setData();
    super.initState();
  }

  //Method to initialse controller
  void initialiseController() {
    emailTextController = TextEditingController();
    nameTextController = TextEditingController();
    contactTextController = TextEditingController();
    primarySkillTextController = TextEditingController();
  }

  //Method to set profile data to controllers
  void setData() {
    if (widget.profile == null) {
      profileViewModel.clearProfileKeys();
      dff.storage.clearCollection<String>(collectionName: 'profile');
    } else {
      emailTextController.text = widget.profile!.emailId;
      nameTextController.text = widget.profile!.name;
      contactTextController.text = widget.profile!.contactNumber;
      primarySkillTextController.text = widget.profile!.primarySkill;
    }
  }

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTextInput(
                  'Email Id',
                  emailTextController,
                  isEnable: widget.profile == null ? true : false,
                ),
                buildTextInput('Name', nameTextController),
                buildTextInput('Contact Number', contactTextController),
                buildTextInput('Primary Skill', primarySkillTextController),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: createOrUpdateProfile,
                        child: Text(
                          widget.profile == null ? 'CREATE' : 'UPDATE',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.profile == null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (final context) =>
                                    const ProfileListScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'SHOW PROFILES',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              const SizedBox.shrink()
         , ],
        ),
      );

  //Method to create or update profile
  void createOrUpdateProfile() {
    if (validateData()) {
      saveProfileData();
      clearController();
      if (widget.profile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile Created Successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile Updated Successfully'),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

//Method to clear controller
  void clearController() {
    emailTextController.clear();
    nameTextController.clear();
    primarySkillTextController.clear();
    contactTextController.clear();
  }

  //Method to validate the user input
  bool validateData() {
    if (emailTextController.text.isNotEmpty &&
        nameTextController.text.isNotEmpty &&
        contactTextController.text.isNotEmpty &&
        primarySkillTextController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

//Method to save & update profile data into storage
  void saveProfileData() {
    final profile = Profile(
      emailTextController.text,
      nameTextController.text,
      primarySkillTextController.text,
      contactTextController.text,
    );

    dff.storage.setItem<String>(
      collectionName: 'profile',
      key: emailTextController.text,
      item: jsonEncode(profile.toJson()),
    );
    profileViewModel.saveProfileKey(emailTextController.text);
  }

  //Method to build text input controller
  Widget buildTextInput(
    final String hint,
    final TextEditingController textEditingController, {
    final bool isEnable = true,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.black),
              enabled: isEnable,
              controller: textEditingController,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                hintText: hint,
              ),
            ),
            const SizedBox(
              height: 16,
            )
        ,  ],
        ),
      );
}
