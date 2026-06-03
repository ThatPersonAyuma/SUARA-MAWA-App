import 'package:flutter/material.dart';

// Re-export or mirror AspirasiStatus from daftar_aspirasi if shared
// For independence, we define status here too. In production, extract
// both to a shared lib/models/ folder and import from there.
enum DetailStatus {
  submitted,
  underReview,
  inProgress,
  resolved;

  String get label {
    return switch (this) {
      DetailStatus.submitted => 'Submitted',
      DetailStatus.underReview => 'Under Review',
      DetailStatus.inProgress => 'In Progress',
      DetailStatus.resolved => 'Resolved',
    };
  }

  Color get activeIconBg {
    return switch (this) {
      DetailStatus.submitted => const Color(0xFF1A2B5F),
      DetailStatus.underReview => const Color(0xFF1A2B5F),
      DetailStatus.inProgress => const Color(0xFF1B4332),
      DetailStatus.resolved => const Color(0xFFEDEEF2),
    };
  }

  Color get activeIconColor {
    return switch (this) {
      DetailStatus.submitted => Colors.white,
      DetailStatus.underReview => Colors.white,
      DetailStatus.inProgress => const Color(0xFF52B788),
      DetailStatus.resolved => const Color(0xFFB0BEC5),
    };
  }

  IconData get icon {
    return switch (this) {
      DetailStatus.submitted => Icons.check_rounded,
      DetailStatus.underReview => Icons.check_rounded,
      DetailStatus.inProgress => Icons.sync_rounded,
      DetailStatus.resolved => Icons.flag_outlined,
    };
  }
}

class TimelineStep {
  final DetailStatus status;
  final String description;
  final String? dateTime;
  final bool isActive;
  final bool isPast;

  const TimelineStep({
    required this.status,
    required this.description,
    this.dateTime,
    this.isActive = false,
    this.isPast = false,
  });
}

class OfficialResponse {
  final String responderName;
  final String timeAgo;
  final String avatarLabel;
  final String message;

  const OfficialResponse({
    required this.responderName,
    required this.timeAgo,
    required this.avatarLabel,
    required this.message,
  });
}

class DetailAspirasiModel {
  final String aspirationId;
  final String category;
  final String dateLabel;
  final String title;
  final DetailStatus currentStatus;
  final String? attachmentImagePath; // null = use placeholder
  final String detailDescription;
  final String locationAddress;
  final List<TimelineStep> timeline;
  final OfficialResponse? officialResponse;

  const DetailAspirasiModel({
    required this.aspirationId,
    required this.category,
    required this.dateLabel,
    required this.title,
    required this.currentStatus,
    this.attachmentImagePath,
    required this.detailDescription,
    required this.locationAddress,
    required this.timeline,
    this.officialResponse,
  });
}

/// Dummy data — replace with API response from Dio
final DetailAspirasiModel dummyDetailAspirasi = DetailAspirasiModel(
  aspirationId: 'ASP-2023-8942',
  category: 'Infrastructure',
  dateLabel: 'Oct 24, 2023',
  title: 'Severe Potholes on Main Street Intersection',
  currentStatus: DetailStatus.inProgress,
  detailDescription:
      'There are several large, deep potholes that have developed on Main Street, '
      'specifically right before the crosswalk at the intersection with Oak Avenue. '
      'These have been getting progressively worse over the last two weeks due to the heavy rains.\n\n'
      'They are currently causing significant disruption to traffic flow as cars are swerving '
      'into the adjacent lane to avoid them. Furthermore, they pose a severe hazard to cyclists '
      'and electric scooters using the designated bike lane nearby. Immediate patch work is requested '
      'before further damage to vehicles occurs.',
  locationAddress: 'Intersection of Main St. & Oak Ave, Downtown District.',
  timeline: [
    TimelineStep(
      status: DetailStatus.submitted,
      description: 'Aspiration received by the system.',
      dateTime: 'Oct 24, 2023 · 09:15 AM',
      isPast: true,
    ),
    TimelineStep(
      status: DetailStatus.underReview,
      description: 'Assigned to Department of Public Works.',
      dateTime: 'Oct 25, 2023 · 10:30 AM',
      isPast: true,
    ),
    TimelineStep(
      status: DetailStatus.inProgress,
      description:
          'Maintenance crew dispatched to location for initial assessment and temporary patching.',
      dateTime: 'Oct 26, 2023 · 08:00 AM',
      isActive: true,
    ),
    TimelineStep(
      status: DetailStatus.resolved,
      description: 'Awaiting final confirmation of permanent repair.',
    ),
  ],
  officialResponse: OfficialResponse(
    responderName: 'Public Works Dept.',
    timeAgo: '2 days ago',
    avatarLabel: 'PW',
    message:
        'Thank you for bringing this to our attention. Our assessment team has reviewed the location. '
        'Due to recent weather, priority patching is scheduled for this week. A full road resurfacing '
        'for that block is planned for Q2 next year.',
  ),
);
