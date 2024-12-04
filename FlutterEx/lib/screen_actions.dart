import 'package:flutter/material.dart';

class ScreenActions extends StatefulWidget {
  List<String> groupActions;

  ScreenActions({super.key, required this.groupActions});

  @override
  State<ScreenActions> createState() => _ScreenActionsState();
}

class _ScreenActionsState extends State<ScreenActions> {
  // Estados para los CheckBox
  bool isOpenChecked = true;
  bool isCloseChecked = true;
  bool isLockChecked = false;
  bool isUnlockChecked = false;
  bool isUnlockShortlyChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actions"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CheckBoxListTile para "Open"
          CheckboxListTile(
            title: const Text("Open"),
            subtitle: const Text("Opens an unlocked door"),
            value: isOpenChecked,
            onChanged: (value) {
              setState(() {
                isOpenChecked = value!;
              });
            },
          ),
          const Divider(),
          // CheckBoxListTile para "Close"
          CheckboxListTile(
            title: const Text("Close"),
            subtitle: const Text("Closes an open door"),
            value: isCloseChecked,
            onChanged: (value) {
              setState(() {
                isCloseChecked = value!;
              });
            },
          ),
          const Divider(),
          // CheckBoxListTile para "Lock"
          CheckboxListTile(
            title: const Text("Lock"),
            subtitle: const Text("Locks a door or all the doors in a room or group of rooms, if closed"),
            value: isLockChecked,
            onChanged: (value) {
              setState(() {
                isLockChecked = value!;
              });
            },
          ),
          const Divider(),
          // CheckBoxListTile para "Unlock"
          CheckboxListTile(
            title: const Text("Unlock"),
            subtitle: const Text("Unlocks a locked door or all the locked doors in an room"),
            value: isUnlockChecked,
            onChanged: (value) {
              setState(() {
                isUnlockChecked = value!;
              });
            },
          ),
          const Divider(),
          // CheckBoxListTile para "Unlock shortly"
          CheckboxListTile(
            title: const Text("Unlock shortly"),
            subtitle: const Text("Unlocks a door during 10 seconds and then locks it if it is closed"),
            value: isUnlockShortlyChecked,
            onChanged: (value) {
              setState(() {
                isUnlockShortlyChecked = value!;
              });
            },
          ),
          const Divider(),
          // Botón Submit
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changes submitted')),
                  );
                },
                child: const Text("Submit"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
