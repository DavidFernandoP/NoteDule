// lib/widgets/notas_form.dart
import 'package:flutter/material.dart';

class NotasForm extends StatefulWidget {
  @override
  _NotasFormState createState() => _NotasFormState();
}

class _NotasFormState extends State<NotasForm> {
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
                  // Guardar el apunte
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
