import 'package:flutter/material.dart';

class HourleyForecastCards extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourleyForecastCards({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        color: const Color.fromARGB(255, 35, 35, 35),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Icon(
                icon,
                size: 32,
              ),
              const SizedBox(height: 10),
              Text(temperature),
            ],
          ),
        ),
      ),
    );
  }
}
