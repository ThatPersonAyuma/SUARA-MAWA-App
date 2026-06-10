import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFDDE1EA), width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'PublicSans',
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Color(0xFF5C6B8A),
        ),
      ),
    );
  }
}
