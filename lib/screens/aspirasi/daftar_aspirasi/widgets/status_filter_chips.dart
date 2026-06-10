import 'package:flutter/material.dart';
import '../models/aspirasi_item.dart';

class StatusFilterChips extends StatelessWidget {
  final AspirasiStatus selectedStatus;
  final ValueChanged<AspirasiStatus> onStatusChanged;

  const StatusFilterChips({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  static const _filters = [
    AspirasiStatus.all,
    AspirasiStatus.verification,
    AspirasiStatus.inProgress,
    AspirasiStatus.done,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _filters.map((status) {
          final isActive = selectedStatus == status;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _FilterChip(
              label: status.label,
              isActive: isActive,
              onTap: () => onStatusChanged(status),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF00BFA5) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF00BFA5) : const Color(0xFFDDE1EA),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: isActive ? Colors.white : const Color(0xFF5C6B8A),
          ),
        ),
      ),
    );
  }
}
