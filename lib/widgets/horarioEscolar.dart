import 'package:flutter/material.dart';
import 'package:notedule/screens/notas_screen.dart';
import 'package:notedule/servicios/database_helper.dart';
import 'package:notedule/modelos/materia_modelo.dart';
import 'package:notedule/sistema/globals.dart';

class HorarioEscolar extends StatefulWidget {
  @override
  _HorarioEscolarState createState() => _HorarioEscolarState();
}

Color getColorFromValue(String value) {
  switch (value) {
    case "FF0000":
      return Color(0xFFFF0000); // Rojo
    case "FF8A00":
      return Color(0xFFFF8A00); // Naranja
    case "FFE500":
      return Color(0xFFFFE500); // Amarillo
    case "05FF00":
      return Color(0xFF05FF00); // Verde
    case "00FFE0":
      return Color(0xFF00FFE0); // Turquesa
    case "001AFF":
      return Color(0xFF001AFF); // Azul
    case "8F00FF":
      return Color(0xFF8F00FF); // Morado
    case "FA00FF":
      return Color(0xFFFA00FF); // Rosa
    case "FF4694":
      return Color(0xFFFF4694); // Rosa claro
    default:
      return Colors.blue; // Color predeterminado si el valor no coincide con ninguno de los casos anteriores
  }
}

class _HorarioEscolarState extends State {
  void actualizarHorario() {
    setState(() {
      // Actualiza el estado del horario escolar aquí
    });
  }

  // Función para mostrar el diálogo emergente
void mostrarConfirmacionEliminar(BuildContext context, Materia materia) {
  // Mostrar un diálogo emergente con AlertDialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Retorna el AlertDialog
      return AlertDialog(
        title: Text('¿Estás seguro de que quieres eliminar la materia: ${materia.nombre}?'),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Botón de "Cancelar"
              TextButton(
                onPressed: () {
                  // Cierra el diálogo emergente sin eliminar la materia
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar', style: TextStyle(fontSize: 20),),
              ),
              // Botón de "Aceptar"
              TextButton(
                onPressed: () {
                  // Elimina la materia y cierra el diálogo emergente
                  DatabaseHelper.deleteNote(materia);
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ],
      );
    },
  );
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Horario Escolar'),
      ),*/
      backgroundColor: globals.negro,
      body: FutureBuilder<List<Materia>?>(
        future: DatabaseHelper.getAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los datos'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return _buildHorario(snapshot.data!);
          } else {
            return Center(
              child: Text('No hay datos disponibles'),
            );
          }
        },
      ),
    );
  }

  Widget _buildHorario(List<Materia> materias) {
    // Define los días de la semana y las horas
    List<String> diasSemana = [' ', 'LUN', 'MAR', 'MIÉ', 'JUE', 'VIE', 'SÁB'];
    List<String> horas = List.generate(13, (index) => '${index + 6}:00');

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: diasSemana.length, 
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
      ),
      itemCount: diasSemana.length * horas.length,
      itemBuilder: (context, index) {
        // Calcula el día y la hora actual
        int diaIndex = index % diasSemana.length;
        int horaIndex = (index ~/ diasSemana.length) % horas.length;
        String dia = diasSemana[diaIndex];
        String hora = horas[horaIndex];

        // Busca si hay una materia para esta hora y día
        /*Materia? materia = materias.firstWhere(
          (materia) =>
              materia.dia == dia &&
              materia.inicio == hora.replaceFirst(":00", ""), //&&
              //materia.fin == hora, // Verifica que la hora actual esté dentro del horario de la materia
          orElse: () => Materia(
            nombre: "", 
            color: "",
            dia: "",
            inicio: "7",
            fin: "7",
          ),
        );*/
        Materia? materia = materias.firstWhere(
          (materia) {
            // Convierte la hora actual a un número entero
            int horaInt = int.parse(hora.split(':')[0]);
            // Convierte las horas de inicio y fin de la materia a enteros
            int inicio = int.parse(materia.inicio);
            int fin = int.parse(materia.fin);

            // Verifica si la hora actual está dentro del rango de la materia
            return materia.dia == dia && horaInt >= inicio && horaInt < fin;
          },
          orElse: () => Materia(
            nombre: "", 
            color: "",
            dia: "",
            inicio: "7",
            fin: "7",
          ),
        );
        // Construye el widget correspondiente
        if (diaIndex == 0 && horaIndex == 0) {
          // Espacio vacío en la esquina superior izquierda
          return Container();
        } else if (diaIndex == 0) {
          // Etiqueta de hora en la columna de horas
          return Container(
            alignment: Alignment.center,
            color: globals.negro,
            child: Text(
              hora,
              style: TextStyle(
                color: globals.blanco, // Color del texto
                fontSize: 15.0, // Tamaño del texto
                fontWeight: FontWeight.bold, // Grosor del texto
              ),
            ),
          );
        } else if (horaIndex == 0) {
          // Etiqueta de día en la fila de días
          return Container(
            alignment: Alignment.center,
            color: globals.negro,
            child: Text(
              dia,
              style: TextStyle(
                color: globals.blanco, // Color del texto
                fontSize: 15.0, // Tamaño del texto
                fontWeight: FontWeight.bold, // Grosor del texto
              ),
            ),
          );
        } else if (materia.nombre != '') {
            // Determina si se debe mostrar el marco rojo
            final mostrarMarcoRojo = globals.eliminar == true;

            return GestureDetector(
              onTap: () {
                if (globals.eliminar == true) {
                  setState(() {
                    // Elimina la materia si el modo eliminar está activado
                    //DatabaseHelper.deleteNote(materia);
                    mostrarConfirmacionEliminar(context, materia);
                  });
                }else {
                  // Navega a otra vista si el modo eliminar no está activado
                  globals.materiaActual = materia.nombre;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotasScreen(),
                    ),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                //color: Colors.blue,
                decoration: BoxDecoration(
                  color: getColorFromValue(materia.color),
                  border: mostrarMarcoRojo
                      ? Border.all(color: Colors.red, width: 2.0) // Mostrar borde rojo si eliminar es verdadero
                      : null, // No mostrar borde rojo si eliminar es falso
                ),
                child: Text(
                  materia.nombre.substring(0, 1),
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            );
          } else {
            // Espacio vacío si no hay materia
            return Container();
          }
      },
    );
  }
}