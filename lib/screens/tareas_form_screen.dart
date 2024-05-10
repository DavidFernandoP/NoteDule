import 'package:flutter/material.dart';
import '../widgets/boton_cancelar.dart'; 
import '../widgets/boton_guardar.dart';


import 'package:flutter/material.dart';
import '../widgets/boton_cancelar.dart'; // Importamos el widget BotonCancelar
import '../widgets/boton_guardar.dart'; // Importamos el widget BotonGuardar
import '../services/tareas_service.dart'; // Importamos el archivo donde está definido el método addTarea

class TareasFormScreen extends StatefulWidget {
  @override
  _TareasFormScreenState createState() => _TareasFormScreenState();
}

class _TareasFormScreenState extends State<TareasFormScreen> {
  // Controladores para los campos de entrada de texto
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
      // Envuelve el contenido en SingleChildScrollView para permitir desplazamiento
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Construye el campo de entrada para el título
              _buildInfoField(
                label: 'Título',
                controller: _tituloController,
              ),
              SizedBox(height: 16.0),
              // Construye el campo de entrada para la fecha
              _buildInfoField(
                label: 'Fecha',
                controller: _fechaController,
              ),
              SizedBox(height: 16.0),
              // Construye el campo de entrada para el contenido
              _buildContentField(_contenidoController),
            ],
          ),
        ),
      ),
      // Barra de navegación inferior con botones de cancelar y guardar
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonCancelar(), // Widget BotonCancelar
            BotonGuardar(
              onPressed: _guardarTarea, // Llamamos a _guardarTarea cuando se presiona el botón "Guardar"
            ),
          ],
        ),
      ),
    );
  }

  // Construye un campo de información con un título y un campo de texto
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

  // Construye un campo de entrada para el contenido
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

  // Método para guardar la tarea
  void _guardarTarea() async {
    // Crear una nueva instancia de Tarea con los datos de los controladores
    Tarea nuevaTarea = Tarea(
      titulo: _tituloController.text,
      contenido: _contenidoController.text,
      fecha: _fechaController.text,
    );

    // Llamar al método addTarea para guardar la tarea en la base de datos
    int resultado = await addTarea(nuevaTarea);

    // Mostrar un diálogo según el resultado de la operación
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

  // Liberar los controladores al destruir el widget
  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    _fechaController.dispose();
    super.dispose();
  }
}
