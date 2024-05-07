// lib/screens/notas_form_screen.dart
import 'package:flutter/material.dart';
import '../widgets/boton_cancelar.dart'; 
import '../widgets/boton_guardar.dart'; 

class NotasFormScreen extends StatefulWidget {
  @override
  _NotasFormScreenState createState() => _NotasFormScreenState();
}

class _NotasFormScreenState extends State<NotasFormScreen> {
  final _tituloController = TextEditingController();
  final _contenidoController = TextEditingController();
  final _fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Nuevo Apunte',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
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
            _buildContentField(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonCancelar(),
            BotonGuardar(),
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

Widget _buildContentField() {
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
            controller: _contenidoController,
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


  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    _fechaController.dispose();
    super.dispose();
  }
}
