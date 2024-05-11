import 'package:flutter/material.dart';
import '../modelos/tarea.dart'; // Importamos el modelo de Tarea

class TareaListItem extends StatefulWidget {
  final Tarea tarea; // Cambiamos el tipo de la propiedad a Tarea
  final ValueChanged<bool> onSelected;

  TareaListItem({required this.tarea, required this.onSelected});

  @override
  _TareaListItemState createState() => _TareaListItemState();
}

class _TareaListItemState extends State<TareaListItem> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.tarea.titulo), // Accedemos al título de la tarea en lugar del apunte
      subtitle: Text(widget.tarea.fecha.toString()), // Accedemos a la fecha de la tarea en lugar del apunte
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
