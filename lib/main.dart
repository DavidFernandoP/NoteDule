import 'package:flutter/material.dart';
import 'package:notedule/widgets/horarioEscolar.dart';
import 'package:notedule/sistema/globals.dart';
import 'package:notedule/widgets/modal.dart';
import 'package:notedule/servicios/database_helper.dart';
import 'modelos/materia_modelo.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los Widgets de Flutter estén inicializados

  // Obtén todas las materias existentes
  List<Materia>? materias = await DatabaseHelper.getAllNotes();

  if (materias != null && materias.isNotEmpty) {
    // Si hay materias en la base de datos, imprímelas por consola
    print("Materias existentes:");
    for (var materia in materias) {
      print("Nombre: ${materia.nombre}, Color: ${materia.color}, Día: ${materia.dia}, Inicio: ${materia.inicio}, Fin: ${materia.fin}");
    }
    /*await DatabaseHelper.deleteAllNotes();
    print("Todas las materias han sido eliminadas");*/
  } else {
    // Si la base de datos está vacía, muestra un mensaje indicándolo
    print("La base de datos está vacía");
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showCancelButton = false;

  void _toggleCancelButton() {
    setState(() {
      _showCancelButton = !_showCancelButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: globals.negro,
          title: Center(
            child: Text(
              'NOTEDULE',
              style: TextStyle(
                color: globals.blanco,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: IconButton(
          icon: Icon(
            Icons.lightbulb_outline,
            color: globals.blanco,
          ),
          onPressed: () {
            setState(() {
              if (globals.negro == Colors.black) {
                globals.negro = Colors.white;
                globals.blanco = Colors.black;
              } else {
                globals.negro = Colors.black;
                globals.blanco = Colors.white;
              }
            });
          },
        ),
        ),
        body: HorarioEscolar(),
        backgroundColor: globals.negro,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: globals.blanco,
                width: 2.0,
              ),
            ),
          ),
          child: BottomAppBar(
            color: globals.negro,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: globals.blanco,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return AddSubjectForm();
                          },
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: globals.blanco
                  ),
                  onPressed: () {
                    setState(() {
                      globals.eliminar = !globals.eliminar;
                    });
                    //_toggleCancelButton(); // Toggle the cancel button
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}