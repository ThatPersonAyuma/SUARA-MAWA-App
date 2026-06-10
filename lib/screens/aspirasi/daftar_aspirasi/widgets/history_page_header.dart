import 'package:flutter/material.dart';

class HistoryPageHeader extends StatelessWidget {
  const HistoryPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aspiration History',
          style: TextStyle(
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w800,
            fontSize: 28,
            height: 1.2,
            color: Color(0xFF0D1B2A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Track the status and progress of your submitted feedback and reports.',
          style: TextStyle(
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.5,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
