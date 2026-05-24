import 'package:flutter/material.dart';
import 'package:suara_mawa/utils/app_colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final Map<String, dynamic> taskData = {
    "id": 12,
    "title": "AC Ruang Kuliah 3.2 Bocor dan Mengeluarkan Suara Bising",
    "description": "Sudah 3 hari AC di ruang kuliah 3.2 bocor airnya deras sampai membasahi lantai depan. Suara kompresornya juga sangat bising mengganggu jalannya perkuliahan...",
    "locationLat": -8.1651,
    "locationLong": 113.7164,
    "isPublic": true,
    "isDeleted": false,
    "likes": 42,
    "category": {"id": 3, "name": "Prasarana"},
    "department": {"id": 2, "name": "TU"},
    "author": {
      "id": "usr_98234",
      "name": "Ahmad Dani",
      "photoProfileUrl": "https://i.pravatar.cc/150?u=ahmad"
    },
    "attachments": [
      {
        "id": 101,
        "name": "bukti-ac-bocor.jpg",
        "filetype": "image",
        "url": "https://images.unsplash.com/photo-1599839619722-39751411ea63?auto=format&fit=crop&q=80"
      },
      {
        "id": 102,
        "name": "rekaman-bising.mp4",
        "filetype": "video",
        "url": "https://images.unsplash.com/photo-1611162617474-5b21e879e113?auto=format&fit=crop&q=80"
      }
    ],
    "statusTimeline": [
      {
        "id": 55,
        "status": "revision",
        "changedAt": "2026-05-24T08:00:00.000Z",
        "changedBy": {"name": "Admin Akademik"},
        "feedback": {
          "id": 9,
          "description": "AC sudah dibersihkan, tetapi airnya masih menetes sedikit di bagian pipa samping. Tolong dicek kembali instalasi pembuangannya.",
          "attachments": [
            {
              "id": 201,
              "name": "foto-pipa-menetes.jpg",
              "filetype": "image",
              "url": "https://images.unsplash.com/photo-1585314062340-f1a5a7c9328d?auto=format&fit=crop&q=80"
            }
          ]
        }
      },
      {
        "id": 42,
        "status": "in_progress",
        "changedAt": "2026-05-23T02:00:00.000Z",
        "changedBy": {"name": "Admin Akademik"},
        "feedback": null
      },
      {
        "id": 10,
        "status": "pending",
        "changedAt": "2026-05-22T14:30:00.000Z",
        "changedBy": {"name": "Ahmad Dani"},
        "feedback": null
      }
    ],
    "comments": [
      {
        "id": 1,
        "comment": "Mohon segera diperbaiki ya pak/bu, besok jam 8 ada ujian di ruangan ini.",
        "createdAt": "2026-05-23T10:00:00.000Z",
        "user": {
          "name": "Rian (Komting Kelas)",
          "photoProfileUrl": "https://i.pravatar.cc/150?u=rian"
        }
      }
    ]
  };

  String _translateStatus(String status) {
    switch (status) {
      case 'pending':
        return 'Menunggu';
      case 'in_progress':
        return 'Diproses';
      case 'revision':
        return 'Perlu Revisi';
      case 'completed':
        return 'Selesai';
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.grey;
      case 'in_progress':
        return Colors.blue;
      case 'revision':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  String _formatDate(String isoString) {
    DateTime date = DateTime.parse(isoString);
    return "${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "Detail Laporan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildTitleAndDescription(),
                  const SizedBox(height: 16),
                  _buildTags(),
                  const SizedBox(height: 20),
                  _buildAttachments(taskData['attachments']),
                  const SizedBox(height: 20),
                  _buildLocation(),
                ],
              ),
            ),
            const SizedBox(height: 8),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Riwayat Status",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildTimeline(),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Container(
            //   color: Colors.white,
            //   padding: const EdgeInsets.all(20.0),
            //   width: double.infinity,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Komentar (${taskData['comments'].length})",
            //         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 16),
            //       _buildComments(),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: _buildBottomAction(),
    );
  }

  Widget _buildHeader() {
    final author = taskData['author'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(author['photoProfileUrl']),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "Dilaporkan pada 12/5/2026 08:30",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: Colors.red.withOpacity(0.1),
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Row(
        //     children: [
        //       const Icon(Icons.favorite, color: Colors.red, size: 16),
        //       const SizedBox(width: 6),
        //       Text(
        //         taskData['likes'].toString(),
        //         style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }

  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          taskData['title'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          taskData['description'],
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[800],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildTags() {
    return Row(
      children: [
        _buildChip(Icons.category_outlined, taskData['category']['name']),
        const SizedBox(width: 12),
        _buildChip(Icons.business_outlined, taskData['department']['name']),
      ],
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachments(List<dynamic> attachments) {
    if (attachments.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Bukti Laporan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: attachments.length,
            itemBuilder: (context, index) {
              final file = attachments[index];
              return Container(
                margin: const EdgeInsets.only(right: 12),
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        file['url'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      ),
                      if (file['filetype'] == 'video')
                        Container(
                          color: Colors.black.withOpacity(0.3),
                          child: const Center(
                            child: Icon(Icons.play_circle_fill, color: Colors.white, size: 36),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    final double lat = taskData['locationLat'];
    final double long = taskData['locationLong'];
    final mapCenter = LatLng(lat, long);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.location_on, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: const Text(
                    "Lokasi Kejadian",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ),
              ],
            ),
          ),

          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            child: SizedBox(
              height: 250,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: mapCenter,
                  initialZoom: 16.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.suaramawa.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: mapCenter,
                        width: 40,
                        height: 40,
                        alignment: Alignment.topCenter,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    List<dynamic> timeline = taskData['statusTimeline'];
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: timeline.length,
      itemBuilder: (context, index) {
        final item = timeline[index];
        final isLast = index == timeline.length - 1;
        final statusColor = _getStatusColor(item['status']);

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(color: statusColor.withOpacity(0.4), blurRadius: 4),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: Colors.grey[300],
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _translateStatus(item['status']),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: statusColor,
                            ),
                          ),
                          Text(
                            _formatDate(item['changedAt']),
                            style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Oleh: ${item['changedBy']['name']}",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),

                      if (item['feedback'] != null)
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange.withOpacity(0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.info_outline, size: 16, color: Colors.orange),
                                  SizedBox(width: 6),
                                  Text("Catatan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['feedback']['description'],
                                style: const TextStyle(fontSize: 13, height: 1.4),
                              ),
                              if (item['feedback']['attachments'] != null && (item['feedback']['attachments'] as List).isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: _buildAttachments(item['feedback']['attachments']),
                                )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildComments() {
    List<dynamic> comments = taskData['comments'];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      separatorBuilder: (context, index) => const Divider(height: 30),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(comment['user']['photoProfileUrl']),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        comment['user']['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        _formatDate(comment['createdAt']),
                        style: TextStyle(color: Colors.grey[500], fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    comment['comment'],
                    style: TextStyle(fontSize: 13, color: Colors.grey[800], height: 1.4),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFF00005C)), // Navy Blue
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text(
                  "Tolak",
                  style: TextStyle(color: Color(0xFF00005C), fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00005C), // Navy Blue
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  elevation: 0,
                ),
                child: const Text(
                  "Tindak Lanjut",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}