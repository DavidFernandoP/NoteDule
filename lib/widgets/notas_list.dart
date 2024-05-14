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
      itemCount: apuntes.length,
      itemBuilder: (context, index) {
        final apunte = apuntes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ApunteCard(
            apunte: apunte,
            onTap: () {
              onApunteSelected(apunte, !apunte.isSelected);
            },
            onLongPress: () {
              onApunteSelected(apunte, !apunte.isSelected);
            },
            isSelected: apunte.isSelected,
          ),
        );
      },
    );
  }
}
