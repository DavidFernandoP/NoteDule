// lib/screens/notas_screen.dart

import 'package:flutter/material.dart';
import '../modelos/apunte.dart';
import '../widgets/notas_list.dart';
import '../widgets/boton_volver.dart';
import '../widgets/boton_nuevo_apunte.dart';
import '../widgets/boton_eliminar.dart';
import '../servicios/database_helper.dart';
import '../sistema/globals.dart';
import '../widgets/BotonIrATareas.dart';

class NotasScreen extends StatefulWidget {
  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  List<Apunte> apuntes = [];

   @override
  void initState() {
    super.initState();
    _cargarApuntesDesdeDB();
    _insertarApuntesDePrueba(); // Llamada al método para insertar apuntes de prueba
  }

  void _insertarApuntesDePrueba() async {
    try {
      await DatabaseHelper().insertarDatosPrueba(); // Llama al método para insertar los apuntes de prueba
    } catch (error) {
      print('Error al insertar apuntes de prueba: $error');
    }
  }

  void _cargarApuntesDesdeDB() async {
    try {
      List<Map<String, dynamic>> apuntesDesdeDB =
          await DatabaseHelper.getApuntes(globals.materiaActual);

      if (apuntesDesdeDB.isNotEmpty) {
        setState(() {
          apuntes.clear(); // Limpiar la lista antes de agregar nuevos apuntes
          apuntes.addAll(
              apuntesDesdeDB.map((apunte) => Apunte.fromJson(apunte)).toList());
        });
      } else {
        print('No hay apuntes en la base de datos.');
      }
    } catch (error) {
      print('Error al cargar los apuntes desde la base de datos: $error');
    }
  }

  void _mostrarContenidoApunte(Apunte apunte) {
    // Mostrar la vista de detalle o un modal con el contenido del apunte
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(apunte.titulo),
          content: Text(apunte.contenido),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globals.negro,
      appBar: AppBar(
        backgroundColor: globals.negro,
        elevation: 0,
        centerTitle: true,
        title: Text(
          globals.materiaActual,
          style: TextStyle(
            color: globals.blanco,
          ),
        ),
        /*leading: BotonIrATareas(), // Utiliza el nuevo widget en lugar de la flecha*/
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                /*
              child: Text(
                globals.materiaActual,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: globals.blanco,
                ),
              ),*/
                ),
          ),
          Expanded(
            child: NotasList(
              apuntes: apuntes,
              onApunteSelected: (apunte, selected) {
                _mostrarContenidoApunte(apunte);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: globals.negro,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BotonVolver(),
            BotonNuevoApunte(materiaActual: globals.materiaActual),
            BotonEliminar(
              apuntes: apuntes,
              materiaActual: globals.materiaActual,
            ),
          ],
        ),
      ),
    );
  }
}
