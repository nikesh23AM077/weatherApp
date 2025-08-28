import 'package:flutter/material.dart';

class WeatherForecastCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const WeatherForecastCard({super.key,
  required this.time,
  required this.icon,
  required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 9,
              ),
              Icon(
                icon,
                size: 30,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                temperature,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
