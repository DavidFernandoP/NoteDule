import 'package:flutter/material.dart';
import 'package:notedule/main.dart';
import 'package:notedule/sistema/globals.dart';
import 'package:notedule/servicios/database_helper.dart';
import '../modelos/materia_modelo.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:notedule/widgets/horarioEscolar.dart';

class AddSubjectForm extends StatefulWidget {
  @override
  AddSubjectFormState createState() => AddSubjectFormState();
}

class AddSubjectFormState extends State<AddSubjectForm> {
  late String nombreValue = "";
  late String diaValue = "";
  late String desdeValue = "7";
  late String hastaValue = "7";
  late String colorValue = "";
  final TextEditingController _nombreController = TextEditingController();

  //final GlobalKey formkey = GlobalKey<FormState>();

  void _guardarMateria(BuildContext context) async {
    nombreValue = _nombreController.text;
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
    /*await DatabaseHelper.deleteAllNotes();
    print("Todas las materias han sido eliminadas");*/
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
                    border: Border.all(color: globals.blanco),
                    borderRadius: BorderRadius.circular(8.0),
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
                    diaValue = 'MIÉ';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: diaValue == 'MIÉ' ? globals.blanco : globals.negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'MIÉ',
                  style: TextStyle(
                    color: diaValue == 'MIÉ' ? globals.negro : globals.blanco,
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
                    diaValue = 'SÁB';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: diaValue == 'SÁB' ? globals.blanco : globals.negro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'SÁB',
                  style: TextStyle(
                    color: diaValue == 'SÁB' ? globals.negro : globals.blanco,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$desdeValue',
                      style: TextStyle(fontSize: 0),
                    ),
                    SizedBox(height: 1),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Ajusta el radio de las esquinas del borde
                        border: Border.all(
                          color: globals.blanco, // Color del borde
                          width: 1, // Ancho del borde
                        ),
                      ),
                      child: Theme(
                        data: ThemeData(
                          textTheme: TextTheme(
                            bodyText1: TextStyle(fontSize: 18, color: globals.blanco), // Ajusta el tamaño del texto del NumberPicker
                          ),
                        ),
                        child: NumberPicker(
                          value: int.parse(desdeValue),
                          minValue: 7,
                          maxValue: 18,
                          itemHeight: 22, // Ajusta el tamaño del ítem del NumberPicker
                          onChanged: (newValue) {
                            setState(() {
                              desdeValue = newValue.toString();
                            });
                          },
                          haptics: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              Text(
                'Hasta',
                style: TextStyle(color: globals.blanco), // Color del texto
              ),
              SizedBox(width: 8.0), // Espacio entre el texto y el campo de entrada
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$hastaValue',
                      style: TextStyle(fontSize: 0),
                    ),
                    SizedBox(height: 1),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Ajusta el radio de las esquinas del borde
                        border: Border.all(
                          color: globals.blanco, // Color del borde
                          width: 1, // Ancho del borde
                        ),
                      ),
                      child: Theme(
                        data: ThemeData(
                          textTheme: TextTheme(
                            bodyText1: TextStyle(fontSize: 18, color: globals.blanco), // Ajusta el tamaño del texto del NumberPicker
                          ),
                        ),
                        child: NumberPicker(
                          value: int.parse(hastaValue),
                          minValue: 7,
                          maxValue: 18,
                          itemHeight: 22, // Ajusta el tamaño del ítem del NumberPicker
                          onChanged: (newValue) {
                            setState(() {
                              hastaValue = newValue.toString();
                            });
                          },
                          haptics: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            width: 350,
            /*decoration: BoxDecoration(
              border: Border.all(color: globals.blanco),
              borderRadius: BorderRadius.circular(5.0),
            ),*/
            child: Wrap(
              spacing: 4.0,
              children: [
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "FF0000";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "FF0000" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón 
                      ),
                      color: Color(0xFFFF0000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "FF8A00";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "FF8A00" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón
                      ),
                      color: Color(0xFFFF8A00),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "FFE500";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "FFE500" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón
                      ),
                      color: Color(0xFFFFE500),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "05FF00";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "05FF00" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón
                      ),
                      color: Color(0xFF05FF00),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "00FFE0";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "00FFE0" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón
                      ),
                      color: Color(0xFF00FFE0),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "001AFF";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "001AFF" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón
                      ),
                      color: Color(0xFF001AFF),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "8F00FF";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "8F00FF" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón
                      ),
                      color: Color(0xFF8F00FF),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "FA00FF";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "FA00FF" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón
                      ),
                      color: Color(0xFFFA00FF),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  setState(() {
                    colorValue = "FF4694";
                  });
                },
                  child: Container(
                    width: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    height: 25, // Ajusta el tamaño del botón aquí según tus necesidades
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorValue == "FF4694" ? globals.blanco : globals.negro,
                        width: 2.0, // Ancho del borde del botón
                      ),
                      color: Color(0xFFFF4694),
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
                  
                  /*setState(() {
                    globals.eliminar = !globals.eliminar;
                  });*/
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
