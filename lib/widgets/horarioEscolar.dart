import 'package:flutter/material.dart';
import 'package:notedule/screens/notas_screen.dart';
import 'package:notedule/servicios/database_helper.dart';
import 'package:notedule/modelos/materia_modelo.dart';
import 'package:notedule/sistema/globals.dart';

class HorarioEscolar extends StatefulWidget {
  @override
  _HorarioEscolarState createState() => _HorarioEscolarState();
}

class _HorarioEscolarState extends State {
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
        Materia? materia = materias.firstWhere(
          (materia) =>
              materia.dia == dia &&
              materia.inicio == hora, //&&
              //materia.fin == hora, // Verifica que la hora actual esté dentro del horario de la materia
          orElse: () => Materia(
            nombre: "", 
            color: "",
            dia: "",
            inicio: "",
            fin: "",
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
                  // Elimina la materia si el modo eliminar está activado
                  DatabaseHelper.deleteNote(materia);
                } else {
                  // Navega a otra vista si el modo eliminar no está activado
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
                  color: Colors.blue,
                  border: mostrarMarcoRojo
                      ? Border.all(color: Colors.red, width: 2.0) // Mostrar borde rojo si eliminar es verdadero
                      : null, // No mostrar borde rojo si eliminar es falso
                ),
                child: Text(
                  materia.nombre,
                  style: TextStyle(color: Colors.white),
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