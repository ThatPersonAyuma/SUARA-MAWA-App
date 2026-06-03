import 'package:flutter/material.dart';

enum AspirasiStatus {
  all,
  verification,
  inProgress,
  done;

  String get label {
    return switch (this) {
      AspirasiStatus.all => 'All',
      AspirasiStatus.verification => 'Verification',
      AspirasiStatus.inProgress => 'In Progress',
      AspirasiStatus.done => 'Done',
    };
  }

  Color get badgeBackgroundColor {
    return switch (this) {
      AspirasiStatus.all => const Color(0xFF00BFA5),
      AspirasiStatus.verification => const Color(0xFFEDEEF2),
      AspirasiStatus.inProgress => const Color(0xFF1B4332),
      AspirasiStatus.done => const Color(0xFF0D1B6E),
    };
  }

  Color get badgeTextColor {
    return switch (this) {
      AspirasiStatus.all => Colors.white,
      AspirasiStatus.verification => const Color(0xFF5C6B8A),
      AspirasiStatus.inProgress => const Color(0xFF52B788),
      AspirasiStatus.done => Colors.white,
    };
  }

  Color get accentBorderColor {
    return switch (this) {
      AspirasiStatus.all => const Color(0xFF00BFA5),
      AspirasiStatus.verification => const Color(0xFFB0BEC5),
      AspirasiStatus.inProgress => const Color(0xFF52B788),
      AspirasiStatus.done => const Color(0xFF0D1B6E),
    };
  }

  IconData get badgeIcon {
    return switch (this) {
      AspirasiStatus.all => Icons.check_circle_outline,
      AspirasiStatus.verification => Icons.assignment_late_outlined,
      AspirasiStatus.inProgress => Icons.sync_rounded,
      AspirasiStatus.done => Icons.check_circle_outline,
    };
  }
}

class AspirasiItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final String dateLabel;
  final AspirasiStatus status;

  const AspirasiItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.dateLabel,
    required this.status,
  });
}

/// Dummy data — replace with API response from Dio
final List<AspirasiItem> dummyAspirations = [
  const AspirasiItem(
    id: 'ASP-001',
    title: 'Upgrade Library Wi-Fi Infrastructure',
    description:
        'The current internet connection in the main library building drops constantly during peak...',
    category: 'Facilities',
    dateLabel: 'Oct 24, 2023',
    status: AspirasiStatus.inProgress,
  ),
  const AspirasiItem(
    id: 'ASP-002',
    title: 'Extend Cafeteria Operating Hours',
    description:
        'Evening students have limited dining options on campus after 7 PM. Requesting to keep at leas...',
    category: 'Services',
    dateLabel: 'Oct 20, 2023',
    status: AspirasiStatus.verification,
  ),
  const AspirasiItem(
    id: 'ASP-003',
    title: 'Fix Broken Projector in Room A302',
    description:
        'The HDMI port on the ceiling projector is loose, causing screen flickering during lectures.',
    category: 'Academic',
    dateLabel: 'Sep 15, 2023',
    status: AspirasiStatus.done,
  ),
];
