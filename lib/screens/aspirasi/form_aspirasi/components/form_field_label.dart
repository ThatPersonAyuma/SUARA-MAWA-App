import 'package:flutter/material.dart';

class FormFieldLabel extends StatelessWidget {
  final String label;

  const FormFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'PublicSans',
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
