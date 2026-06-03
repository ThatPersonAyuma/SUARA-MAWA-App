import 'package:flutter/material.dart';
import '../models/detail_aspirasi_model.dart';

class TimelineStepItem extends StatelessWidget {
  final TimelineStep step;
  final bool isLast;

  const TimelineStepItem({super.key, required this.step, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final bool isDimmed = !step.isActive && !step.isPast;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column: icon + vertical connector line
          SizedBox(
            width: 36,
            child: Column(
              children: [
                _StepIcon(step: step, isDimmed: isDimmed),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: step.isPast
                          ? const Color(0xFF1A2B5F)
                          : const Color(0xFFDDE1EA),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // Right column: label + description + datetime
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.status.label,
                    style: TextStyle(
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: isDimmed
                          ? Colors.grey.shade400
                          : const Color(0xFF0D1B2A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    step.description,
                    style: TextStyle(
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: isDimmed
                          ? Colors.grey.shade300
                          : Colors.grey.shade600,
                    ),
                  ),
                  if (step.dateTime != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      step.dateTime!,
                      style: TextStyle(
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIcon extends StatelessWidget {
  final TimelineStep step;
  final bool isDimmed;

  const _StepIcon({required this.step, required this.isDimmed});

  @override
  Widget build(BuildContext context) {
    if (isDimmed) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFDDE1EA), width: 1.5),
          color: Colors.white,
        ),
        child: Icon(step.status.icon, size: 14, color: Colors.grey.shade300),
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: step.status.activeIconBg,
      ),
      child: Icon(
        step.status.icon,
        size: 15,
        color: step.status.activeIconColor,
      ),
    );
  }
}
