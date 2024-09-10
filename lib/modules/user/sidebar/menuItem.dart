import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Expanded( // Esto ajusta el texto al espacio disponible
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis, // Esto trunca el texto si es demasiado largo
              ),
            ),
          ],
        ),
      ),
    );
  }
}
