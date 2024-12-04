import 'package:flutter/material.dart';

class ScreenInfo extends StatefulWidget {
  final String groupName;
  final String groupDescription;

  const ScreenInfo({
    super.key,
    required this.groupName,
    required this.groupDescription,
  });

  @override
  State<ScreenInfo> createState() => _ScreenInfoState();
}

class _ScreenInfoState extends State<ScreenInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los valores de los campos
    _nameController.text = widget.groupName;
    _descriptionController.text = widget.groupDescription;
  }

  @override
  void dispose() {
    // Liberar los controladores
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Info Employees"),
      ),
      body: Center( // Centrar los elementos en la pantalla
        child: SingleChildScrollView( // Permitir desplazamiento si es necesario
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrar en el eje vertical
            crossAxisAlignment: CrossAxisAlignment.start, // Alinear en el eje horizontal
            children: [
              // Campo de texto para el nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name Group",
                  border: OutlineInputBorder(),
                ),
              ),
              // Espacio más grande entre Name Group y Description
              const SizedBox(height: 100.0), // Incrementar el valor aquí
              // Campo de texto para la descripción
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
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
