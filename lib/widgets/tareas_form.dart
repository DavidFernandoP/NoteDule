import 'package:flutter/material.dart';

class TareasForm extends StatefulWidget {
  @override
  _TareasFormState createState() => _TareasFormState();
}

class _TareasFormState extends State<TareasForm> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _contenidoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _tituloController,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _contenidoController,
            decoration: InputDecoration(labelText: 'Contenido'),
            maxLines: null,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Guardar la tarea
                  Navigator.pop(context);
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
