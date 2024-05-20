import 'package:flutter/material.dart';
import 'group_edit_screen.dart';
import 'group_model.dart';

class GroupCard extends StatelessWidget {
  final GroupModel groupInfo;

  const GroupCard({super.key, required this.groupInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditGroupScreen(
              groupInfo: groupInfo,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Theme.of(context).colorScheme.onSecondary,
        child: ListTile(
          leading: Icon(
            groupInfo.groupIcon,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          title: Text(
            groupInfo.groupName,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
