import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_device_feature/contacts/contacts_utils.dart';
import 'package:tcs_dff_device_feature/contacts/device_contact.dart';
import 'package:tcs_dff_types/exceptions.dart';

class DemoReadUserDeviceContacts extends StatefulWidget {
  const DemoReadUserDeviceContacts({super.key});

  @override
  State<DemoReadUserDeviceContacts> createState() =>
      _DemoReadUserDeviceContactsState();
}

class _DemoReadUserDeviceContactsState
    extends State<DemoReadUserDeviceContacts> {
  late DeviceContact _deviceContact;
  List<UserContact> _userContacts = [];
  Map<String, int> alphabetOrder = {};
  late ScrollController _scrollController;
  String? _selectedAlphabet;
  double height = 0.0;
  bool isAlphabetOrderClick = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _deviceContact = DeviceContact();
    setScrollListener();
    readUserContacts();
  }

  void setScrollListener() {
    _scrollController.addListener(() async {
      if (height <= 0.0) {
        height = GlobalObjectKey(alphabetOrder[alphabetOrder.keys.first]!)
            .currentContext!
            .size!
            .height;
      }

      if (!isAlphabetOrderClick) {
        final tempAlphabet =
            _userContacts[(_scrollController.offset / height).round() + 1]
                .displayName
                .characters
                .first
                .toUpperCase();
        if (tempAlphabet != _selectedAlphabet) {
          _selectedAlphabet = tempAlphabet;
          setState(() {});
        }
      }
    });
  }

  Future<void> readUserContacts() async {
    try {
      _userContacts = await _deviceContact.getContacts();
      setState(() {});
    } on DevicePermissionException catch (e) {
      showErrorMessageOnSnackBar(e);
    }
  }

  @override
  Widget build(final BuildContext context) => BaseScaffoldWidget(
        body: Stack(
          children: [
            Listener(
              behavior: HitTestBehavior.translucent,
              onPointerUp: (final _) => isAlphabetOrderClick = false,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _userContacts.length,
                  shrinkWrap: true,
                  itemBuilder: (final context, final index) {
                    if (_userContacts[index].phones.isNotEmpty) {
                      return Column(
                        key: getKey(
                          _userContacts[index]
                              .displayName
                              .characters
                              .first
                              .toUpperCase(),
                          index,
                        ),
                        children: [
                          TitleSubtitleTextWidget(
                            title: _userContacts[index].displayName,
                            titleTextStyle: context
                                .theme.appTextStyles.bodyCopy1Large18Bold,
                            subtitle: _userContacts[index].phones.first.number,
                          ),
                          Divider(
                            color: context.theme.appColor.greenDark,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: AlphabeticalOrder(
                selectedAlphabet: _selectedAlphabet ?? '',
                onAlphabetSelect: (final alphabet) {
                  if (alphabetOrder.containsKey(alphabet)) {
                    isAlphabetOrderClick = true;
                    Scrollable.ensureVisible(
                      GlobalObjectKey(alphabetOrder[alphabet]!).currentContext!,
                      duration: const Duration(
                        milliseconds: 100,
                      ), // duration for scrolling time
                      // 0 mean, scroll to the top, 0.5 mean, half
                      curve: Curves.easeInOutCubic,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );

  GlobalObjectKey getKey(final String alphabet, final int index) {
    if (!alphabetOrder.containsKey(alphabet)) {
      alphabetOrder[alphabet] = index;
    }
    return GlobalObjectKey(index);
  }

  void showErrorMessageOnSnackBar(final DevicePermissionException e) {
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: e.error.title),
          const SizedBox(
            height: 4,
          ),
          TextWidget(text: e.error.description),
        ],
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
