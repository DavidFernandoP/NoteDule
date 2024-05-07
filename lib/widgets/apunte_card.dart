// lib/widgets/apunte_card.dart
import 'package:flutter/material.dart';
import '../modelos/apunte.dart';

class ApunteCard extends StatelessWidget {
  final Apunte apunte;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isSelected;

  ApunteCard({required this.apunte, required this.onTap, required this.onLongPress, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.grey[200] : Colors.transparent,
      child: ListTile(
        title: Text(
          apunte.titulo,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          apunte.fecha.toString(),
          style: TextStyle(color: Colors.grey),
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
