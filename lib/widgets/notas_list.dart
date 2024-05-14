// lib/widgets/notas_list.dart
import 'package:flutter/material.dart';
import '../modelos/apunte.dart';
import 'apunte_card.dart';

class NotasList extends StatelessWidget {
  final List<Apunte> apuntes;
  final Function(Apunte, bool) onApunteSelected;

  NotasList({required this.apuntes, required this.onApunteSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: apuntes.length, // No se necesita +1 ya que no hay elemento adicional
      itemBuilder: (context, index) {
        final apunte = apuntes[index]; // Eliminar la resta de 1
        return Column(
          children: [
            ApunteCard(
              apunte: apunte,
              onTap: () {
                onApunteSelected(apunte, !apunte.isSelected);
              },
              onLongPress: () {
                onApunteSelected(apunte, !apunte.isSelected);
              },
              isSelected: apunte.isSelected,
            ),
            Divider( // Separador entre apuntes
              color: Colors.grey.withOpacity(0.5),
              thickness: 1, 
            ),
          ],
        );
      },
    );
  }
}

