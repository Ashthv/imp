import 'package:flutter/material.dart';
import '../model/profile.dart';

class WidgetProfileListItem extends StatelessWidget {
  final Profile profile;
  final Function(String string) onDeletePress;
  const WidgetProfileListItem({
    super.key,
    required this.profile,
    required this.onDeletePress,
  });

  @override
  Widget build(final BuildContext context) => Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    profile.emailId,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.primarySkill,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      profile.contactNumber,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: InkWell(
                  onTap: () {
                    onDeletePress(
                      profile.emailId,
                    );
                  },
                  child: const Icon(Icons.delete),
                ),
              ),
            ),
          ],
        ),
      );
}
