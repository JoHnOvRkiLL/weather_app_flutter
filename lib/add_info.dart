import 'package:flutter/material.dart';

class AddInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AddInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(label),
          const SizedBox(
            height: 8,
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
