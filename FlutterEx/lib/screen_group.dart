import 'package:exercici_flutter/data.dart';
import 'package:exercici_flutter/screen_actions.dart';
import 'package:exercici_flutter/screen_info.dart';
import 'package:exercici_flutter/screen_list_users.dart';
import 'package:exercici_flutter/screen_schedule.dart';
import 'package:flutter/material.dart';

class ScreenGroup extends StatefulWidget {
  final UserGroup userGroup;

  const ScreenGroup({super.key, required this.userGroup});

  @override
  State<ScreenGroup> createState() => _ScreenGroupState();
}

class _ScreenGroupState extends State<ScreenGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Group Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Dos columnas
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildGridTile(Icons.info, "Info"),
            _buildGridTile(Icons.schedule, "Schedule"),
            _buildGridTile(Icons.settings, "Actions"),
            _buildGridTile(Icons.place, "Places"),
            _buildGridTile(Icons.people, "Users"),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTile(IconData icon, String label) {
  return GestureDetector(
    onTap: () {
      if (label == "Info") {
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => ScreenInfo(
            groupName: widget.userGroup.name,
            groupDescription: widget.userGroup.description,
          ),
        ));
      } else if (label =="Schedule") { 
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => ScreenSchedule(
            schedule: widget.userGroup.schedule
          ),
        ));
      } else if (label =="Actions") { 
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => ScreenActions(
            groupActions: widget.userGroup.actions,
          ),
        ));
      } else if (label =="Places") { 
        
      } else if (label =="Users") { 
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => ScreenListUsers(
            users: widget.userGroup.users
          ),
        ));
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80.0, color: Colors.white),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

}


