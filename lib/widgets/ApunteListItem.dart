//lib\widgets\ApunteListItem.dart

import 'package:flutter/material.dart';
import '../modelos/apunte.dart';

class ApunteListItem extends StatefulWidget {
  final Apunte apunte;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  ApunteListItem({required this.apunte, required this.isSelected, required this.onSelected});

  @override
  _ApunteListItemState createState() => _ApunteListItemState();
}

class _ApunteListItemState extends State<ApunteListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.apunte.titulo,
        style: TextStyle(color: widget.isSelected ? Colors.black : Colors.white),
      ),
      subtitle: Text(widget.apunte.fecha.toString()),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            widget.onSelected(!widget.isSelected);
          });
        },
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
            color: widget.isSelected ? Colors.white : Colors.transparent,
          ),
          child: widget.isSelected ? Icon(Icons.check, color: Colors.black) : null,
        ),
      ),
    );
  }
}
