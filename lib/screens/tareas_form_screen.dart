import 'package:flutter/material.dart';
import '../widgets/boton_cancelar.dart'; 
import '../widgets/boton_guardar_tarea.dart'; 
import '../servicios/database_helper.dart'; 
import '../modelos/tarea.dart';

class TareasFormScreen extends StatefulWidget {
  @override
  _TareasFormScreenState createState() => _TareasFormScreenState();
}

class _TareasFormScreenState extends State<TareasFormScreen> {
  final _tituloController = TextEditingController();
  final _contenidoController = TextEditingController();
  final _fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Nueva Tarea',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoField(
                label: 'Título',
                controller: _tituloController,
              ),
              SizedBox(height: 16.0),
              _buildInfoField(
                label: 'Fecha',
                controller: _fechaController,
              ),
              SizedBox(height: 16.0),
              _buildContentField(_contenidoController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonCancelar(),
            BotonGuardar(
              context: context,
              tituloController: _tituloController,
              contenidoController: _contenidoController,
              fechaController: _fechaController,
              onPressed: _guardarTarea,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField({required String label, required TextEditingController controller}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentField(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contenido:',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.black),
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _guardarTarea() async {
    Tarea nuevaTarea = Tarea(
      titulo: _tituloController.text,
      contenido: _contenidoController.text,
      fecha: _fechaController.text.isNotEmpty
          ? DateTime.parse(_fechaController.text)
          : DateTime.now(),
    );

    int resultado = await DatabaseHelper.addTarea(nuevaTarea);

    if (resultado != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Éxito'),
          content: Text('La tarea se guardó correctamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un error al guardar la tarea.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    _fechaController.dispose();
    super.dispose();
  }
}
