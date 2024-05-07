import 'package:flutter/material.dart';
import '../modelos/apunte.dart';
import '../widgets/icono_eliminar.dart';
import '../widgets/boton_volver.dart';
import '../widgets/boton_eliminar.dart';

class EliminarApuntesScreen extends StatelessWidget {
  final List<Apunte> apuntes;

  EliminarApuntesScreen({required this.apuntes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Container(),
        title: Center(
          child: Text(
            'NOTEDULE',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Proyecto Integrador 3',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: apuntes.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                    child: Text(
                      'Apuntes:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  final apunte = apuntes[index - 1];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          apunte.titulo,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          apunte.fecha.toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconoEliminar(
                          onPressed: () {},
                        ),
                      ),
                      Divider( 
                        color: Colors.grey.withOpacity(0.5), 
                        thickness: 1, 
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonVolver(),
            BotonEliminar(apuntes: apuntes),
          ],
        ),
      ),
    );
  }
}
