import 'dart:ui';

import 'package:flutter/material.dart';

class MainWeatherCard extends StatelessWidget {
  final String temperature;
  final String condition;
  final IconData icon;
  const MainWeatherCard(
      {super.key,
      required this.temperature,
      required this.condition,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color.fromARGB(255, 35, 35, 35),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    temperature,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Icon(
                    icon,
                    size: 55,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    condition,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
