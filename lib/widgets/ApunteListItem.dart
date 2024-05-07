//lib\widgets\ApunteListItem.dart

import 'package:flutter/material.dart';
import '../modelos/apunte.dart';

class ApunteListItem extends StatefulWidget {
  final Apunte apunte;
  final ValueChanged<bool> onSelected;

  ApunteListItem({required this.apunte, required this.onSelected});

  @override
  _ApunteListItemState createState() => _ApunteListItemState();
}

class _ApunteListItemState extends State<ApunteListItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.apunte.titulo),
      subtitle: Text(widget.apunte.fecha.toString()),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
            widget.onSelected(_isSelected);
          });
        },
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
            color: _isSelected ? Colors.white : Colors.transparent,
          ),
          child: _isSelected ? Icon(Icons.check, color: Colors.black) : null,
        ),
      ),
    );
  }
}
