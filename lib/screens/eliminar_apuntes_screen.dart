//lib\screens\eliminar_apuntes_screen.dart

import 'package:flutter/material.dart';
import '../modelos/apunte.dart';
import '../widgets/icono_eliminar.dart';
import '../widgets/boton_volver.dart';
import '../widgets/boton_eliminar.dart';
import '../servicios/database_helper.dart';
import '../sistema/globals.dart'; // Importamos globals.dart

class EliminarApuntesScreen extends StatefulWidget {
  final List<Apunte> apuntes;
  final String materiaActual;

  EliminarApuntesScreen({
    required this.apuntes,
    required this.materiaActual,
  });

  @override
  _EliminarApuntesScreenState createState() => _EliminarApuntesScreenState();
}

class _EliminarApuntesScreenState extends State<EliminarApuntesScreen> {
  List<Apunte> _apuntes = [];

  @override
  void initState() {
    super.initState();
    _apuntes = List.from(widget.apuntes);
  }

  void _eliminarApunte(int index) async {
  Apunte apunte = _apuntes[index];
  try {
    await DatabaseHelper.deleteApunte(apunte);
  } catch (error) {
    print('Error al eliminar el apunte de la base de datos: $error');
    return;
  }
  setState(() {
    _apuntes.removeAt(index);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eliminar Apuntes - ${widget.materiaActual}',
          style: TextStyle(
              color: globals
                  .blanco), // Utilizamos globals.blanco para el color del texto
        ),
        backgroundColor:
            globals.negro, // Utilizamos globals.negro para el color del appbar
      ),
      backgroundColor:
          globals.negro, // Establecemos el color de fondo del Scaffold
      body: ListView.builder(
        itemCount: _apuntes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_apuntes[index].titulo),
            subtitle: Text(_apuntes[index].fecha.toString()),
            trailing: IconoEliminar(
              onPressed: () {
                _eliminarApunte(index);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: globals
            .negro, // Utilizamos globals.negro para el color del bottomNavigationBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonVolver(),
            BotonEliminar(
              apuntes: _apuntes,
              materiaActual: widget.materiaActual,
            ),
          ],
        ),
      ),
    );
  }
}
