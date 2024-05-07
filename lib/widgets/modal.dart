import 'package:flutter/material.dart';
import 'package:notedule/main.dart';
import 'package:notedule/sistema/globals.dart';
import 'package:notedule/servicios/database_helper.dart';
import '../modelos/materia_modelo.dart';

class AddSubjectForm extends StatefulWidget {
  @override
  AddSubjectFormState createState() => AddSubjectFormState();
}

class AddSubjectFormState extends State<AddSubjectForm> {
  late String nombreValue = "";
  late String diaValue = "";
  late String desdeValue = "";
  late String hastaValue = "";
  late String colorValue = "";

  final GlobalKey formkey = GlobalKey<FormState>();

  void _guardarMateria(BuildContext context) async {
  Materia materia = Materia(
    nombre: nombreValue,
    color: colorValue,
    dia: diaValue,
    inicio: desdeValue,
    fin: hastaValue,
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
                    //controller: _nombreController, // Asocia el controlador al campo de texto
                    onSaved: (value){
                      nombreValue = value!;
                    },
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
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    diaValue = 'LUN';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: diaValue == 'LUN' ? globals.blanco : globals.negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'LUN',
                  style: TextStyle(
                    color: diaValue == 'LUN' ? globals.negro : globals.blanco,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    diaValue = 'MAR';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: diaValue == 'MAR' ? globals.blanco : globals.negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'MAR',
                  style: TextStyle(
                    color: diaValue == 'MAR' ? globals.negro : globals.blanco,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    diaValue = 'MIE';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: diaValue == 'MIE' ? globals.blanco : globals.negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'MIE',
                  style: TextStyle(
                    color: diaValue == 'MIE' ? globals.negro : globals.blanco,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    diaValue = 'JUE';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: diaValue == 'JUE' ? globals.blanco : globals.negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'JUE',
                  style: TextStyle(
                    color: diaValue == 'JUE' ? globals.negro : globals.blanco,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    diaValue = 'VIE';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: diaValue == 'VIE' ? globals.blanco : globals.negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'VIE',
                  style: TextStyle(
                    color: diaValue == 'VIE' ? globals.negro : globals.blanco,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    diaValue = 'SAB';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: diaValue == 'SAB' ? globals.blanco : globals.negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'SAB',
                  style: TextStyle(
                    color: diaValue == 'SAB' ? globals.negro : globals.blanco,
                  ),
                ),
              ),
            ), 
          ],
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
                    onSaved: (value){
                      desdeValue = value!;
                    },
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
                    onSaved: (value){
                      hastaValue = value!;
                    },
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
