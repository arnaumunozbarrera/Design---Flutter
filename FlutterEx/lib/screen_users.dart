import 'package:exercici_flutter/data.dart';
import 'package:exercici_flutter/screen_actions.dart';
import 'package:exercici_flutter/screen_info.dart';
import 'package:exercici_flutter/screen_list_users.dart';
import 'package:exercici_flutter/screen_schedule.dart';
import 'package:flutter/material.dart';

class ScreenUser extends StatefulWidget {
  final User user;

  const ScreenUser({super.key, required this.user});

  @override
  State<ScreenUser> createState() => _ScreenGroupState();
}

class _ScreenGroupState extends State<ScreenUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _credentialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los valores de los campos
    _nameController.text = widget.user.name;
    _credentialController.text = widget.user.credential;
  }

  @override
  void dispose() {
    // Liberar los controladores
    _nameController.dispose();
    _credentialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("User"),
      ),
      body: Center( // Centrar los elementos en la pantalla
        child: SingleChildScrollView( // Permitir desplazamiento si es necesario
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrar en el eje vertical
            crossAxisAlignment: CrossAxisAlignment.center, // Alinear en el eje horizontal
            children: [
              // Imagen
              ElevatedButton(
                onPressed: () { }, // pick an image from a file
                child: CircleAvatar(
                  radius: 80.0,
                  foregroundImage: AssetImage(Data.images[widget.user.name.toLowerCase()]!),
                ),
              ),
              const SizedBox(height: 32.0),
              // Campo de texto para el nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              // Espacio más grande entre Name Group y Description
              const SizedBox(height: 100.0), // Incrementar el valor aquí
              // Campo de texto para la descripción
              TextFormField(
                controller: _credentialController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "credential",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 110.0), // Espacio entre el último campo y el botón
              // Botón de guardar
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Mostrar mensaje de guardado
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved')),
                    );
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


