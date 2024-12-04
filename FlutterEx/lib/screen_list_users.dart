import 'dart:io';

import 'package:exercici_flutter/screen_users.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'the_drawer.dart';

class ScreenListUsers extends StatefulWidget {
  final List<User> users;

  ScreenListUsers({super.key, required this.users});

  @override
  State<ScreenListUsers> createState() => _ScreenListUsersState();
}

class _ScreenListUsersState extends State<ScreenListUsers> {
  late List<User> users;

  @override
  void initState() {
    super.initState();
    users = widget.users; // Inicializamos la lista de usuarios
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Añadimos un nuevo usuario con datos predeterminados
          User newUser = User("New User", "00000"); // Puedes personalizar estos valores
          users.add(newUser);
          setState(() {}); // Actualizamos la lista de usuarios
        },
      ),
      drawer: TheDrawer(context).drawer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Users"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildRow(users[index], index),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _buildRow(User user, int index) {
    return ListTile(
      leading: CircleAvatar(foregroundImage: AssetImage(Data.images[user.name.toLowerCase()]!),
      ),
      title: Text(user.name), // Muestra el nombre del usuario
      trailing: Text(user.credential), // Muestra el credencial del usuario
      onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => ScreenUser(user: user)),
      )
      .then((var v) => setState(() {})), // Actualiza el estado después de volver
    );
  }
}
