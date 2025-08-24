import 'package:flutter/material.dart';

class Addtional_Info extends StatelessWidget {
  final IconData icon;
  final String climate;
  final String temperature;
  Addtional_Info(
      {super.key, 
      required this.icon,
       required this.climate,
       required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
          ),
          Text(
            climate,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          Text(
            temperature as String,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          )
        ],
      ),
    );
  }
}
