import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = screenHeight * 0.03;
    final fontSize = screenHeight * 0.02;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(icon, color: Colors.white, size: iconSize),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
