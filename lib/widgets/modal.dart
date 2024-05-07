//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:notedule/main.dart';
import 'package:notedule/sistema/globals.dart';
import 'package:notedule/servicios/database_helper.dart';

import '../modelos/materia_modelo.dart';

class AddSubjectForm extends StatelessWidget {
  final List<String> daysOfWeek = ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB']; // Definición de daysOfWeek
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _finController = TextEditingController();

  void _guardarMateria(BuildContext context) async {
  // Obtener valores de los campos del formulario
  String nombre = _nombreController.text;
  String colorHex = "";
  String dia = "LUN";
  String inicio = _inicioController.text;
  String fin = _finController.text;

  // Crear una instancia del modelo de datos Materia con los valores del formulario
  Materia materia = Materia(
    nombre: nombre,
    color: colorHex,
    dia: dia,
    inicio: inicio,
    fin: fin,
  );

  // Agregar la materia a la base de datos utilizando DatabaseHelper
  await DatabaseHelper.addNote(materia);

  // Cerrar el modal
  Navigator.of(context as BuildContext).pop();

  List<Materia>? materias = await DatabaseHelper.getAllNotes();

  if (materias != null && materias.isNotEmpty) {
    // Si hay materias en la base de datos, imprímelas por consola
    print("Materias existentes:");
    for (var materia in materias) {
      print("Nombre: ${materia.nombre}, Color: ${materia.color}, Día: ${materia.dia}, Inicio: ${materia.inicio}, Fin: ${materia.fin}");
    }
    await DatabaseHelper.deleteAllNotes();
    print("Todas las materias han sido eliminadas");
  } else {
    // Si la base de datos está vacía, muestra un mensaje indicándolo
    print("La base de datos está vacía");
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: globals.negro, // Fondo negro
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Nombre',
                style: TextStyle(color: globals.blanco), // Color del texto
              ),
              SizedBox(width: 8.0), // Espacio entre el texto y el campo de entrada
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: globals.blanco), // Define el borde del Container
                    borderRadius: BorderRadius.circular(8.0), // Personaliza la esquina del borde
                  ),
                  child: TextFormField(
                    controller: _nombreController, // Asocia el controlador al campo de texto
                    style: TextStyle(color: globals.blanco),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: globals.negro,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: daysOfWeek.map((day) => SizedBox(
              width: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  // Almacenar el valor de day en la variable dia
                  String diaSeleccionado = day;
                  
                  // Opcional: Puedes imprimir el día seleccionado para verificar
                  print('Día seleccionado: $diaSeleccionado');
                  
                  // Aquí puedes hacer lo que necesites con la variable diaSeleccionado
                },
                style: ElevatedButton.styleFrom(
                  primary: globals.negro,
                  onPrimary: globals.blanco,
                  side: BorderSide(color: globals.blanco),
                ),
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8.0),
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Text(
                'Desde',
                style: TextStyle(color: globals.blanco), // Color del texto
              ),
              SizedBox(width: 8.0), // Espacio entre el texto y el campo de entrada
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: globals.blanco), // Define el borde del Container
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: globals.blanco), // Color del texto dentro del campo
                    decoration: InputDecoration(
                      filled: true, // Activa el relleno
                      fillColor: globals.negro, // Color del fondo del campo de entrada de texto
                      border: OutlineInputBorder( // Define el borde del campo
                        borderRadius: BorderRadius.circular(8.0), // Personaliza la esquina del borde
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              Text(
                'Hasta',
                style: TextStyle(color: globals.blanco), // Color del texto
              ),
              SizedBox(width: 8.0), // Espacio entre el texto y el campo de entrada
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: globals.blanco), // Define el borde del Container
                    borderRadius: BorderRadius.circular(8.0), // Personaliza la esquina del borde
                  ),
                  child: TextFormField(
                    style: TextStyle(color: globals.blanco), // Color del texto dentro del campo
                    decoration: InputDecoration(
                      filled: true, // Activa el relleno
                      fillColor: globals.negro, // Color del fondo del campo de entrada de texto
                      border: OutlineInputBorder( // Define el borde del campo
                        borderRadius: BorderRadius.circular(8.0), // Personaliza la esquina del borde
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: globals.blanco),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Wrap(
              spacing: 2.0,
              children: [
                InkWell(
                  onTap: () {
                    // Almacenar el color seleccionado
                    String colorHex = "#FF0000"; // Cambia el color hexadecimal según el botón
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#FF0000".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String colorHex = "#FF8A00";
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#FF8A00".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String colorHex = "#FFE500";
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#FFE500".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String colorHex = "#05FF00";
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#05FF00".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String colorHex = "#00FFE0";
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#00FFE0".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String colorHex = "#001AFF";
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#001AFF".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String colorHex = "#8F00FF";
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#8F00FF".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String colorHex = "#FA00FF";
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#FA00FF".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String colorHex = "#FF4694";
                    //_onColorSelected(colorHex);
                  },
                  child: Container(
                    width: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    height: 20.0, // Ajusta el tamaño del contenedor para que sea un cuadrado
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse("#FF4694".substring(1, 7), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.clear,
                  color: globals.blanco,
                ),
              ),
              TextButton(
                onPressed: () {
                  _guardarMateria(context); // Pasa el contexto como parámetro
                },
                child: Icon(
                  Icons.check,
                  color: globals.blanco,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//-------------------------boton de color---------------------------------

Widget _colorButton(String colorHex) {
  return Container(
    width: 20.0, // Ancho del botón
    height: 20.0, // Alto del botón
    margin: EdgeInsets.only(right: 8.0), // Margen derecho para separar los botones horizontalmente
    decoration: BoxDecoration(
      shape: BoxShape.circle, // Hace que el botón sea circular
      color: Color(int.parse(colorHex.substring(1, 7), radix: 16) + 0xFF000000), // Convierte el color hexadecimal en Color
    ),
  );
}

//--------------------------Conversor del codigo de color----------------------------

Color _hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

