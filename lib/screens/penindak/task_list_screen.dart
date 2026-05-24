import 'package:flutter/material.dart';
import 'package:suara_mawa/utils/app_colors.dart';
import 'package:suara_mawa/screens/penindak/task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'Perlu Dikerjakan',
      'icon': Icons.list_alt,
      'count': '8',
    },
    {
      'title': 'Perlu Revisi',
      'icon': Icons.autorenew,
      'count': '3',
    },
    {
      'title': 'Selesai',
      'icon': Icons.check_circle_outline,
      'count': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomTabs(),
                const SizedBox(height: 24),
                _buildTabContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTabIndex == index;
          final tab = _tabs[index];

          final String displayText = tab['count'].toString().isNotEmpty
              ? "${tab['title']} (${tab['count']})"
              : tab['title'];

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tab['icon'],
                      size: 20,
                      color: isSelected ? AppColors.white : AppColors.inactive,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      displayText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? AppColors.white : AppColors.inactive,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    if (_selectedTabIndex == 0) {
      return Column(
        children: [
          _buildTaskCard(
            imageUrl: 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?auto=format&fit=crop&q=80', // Placeholder gambar jalan berlubang
            title: 'Severe Pothole on Main Arterial Road',
            category: 'Prasarana',
            description: 'A very deep pothole has formed in the middle lane, causing multiple vehicles to swerve dangerously to avoid it...',
            timeAgo: 'Dilaporkan 2 jam lalu',
            buttonLabel: 'Tindak',
            onActionPressed: () {},
            onCardTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
              );
            },
          ),
          _buildTaskCard(
            imageUrl: 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?auto=format&fit=crop&q=80',
            title: 'Lampu Penerangan Jalan Mati',
            category: 'Mata Kuliah',
            description: 'Lampu PJU di dekat halte busway mati total sejak 3 hari yang lalu, membuat jalanan menjadi sangat gelap saat malam.',
            timeAgo: 'Dilaporkan 5 jam lalu',
            buttonLabel: 'Tindak',
            onActionPressed: () {},
            onCardTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
              );
            },
          ),
        ],
      );
    } else if (_selectedTabIndex == 1) {
      return Column(
        children: [
          _buildTaskCard(
            imageUrl: 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?auto=format&fit=crop&q=80',
            title: 'Perbaikan Pipa Bocor Belum Selesai',
            category: 'Pengajar',
            description: 'Penambalan sementara sudah dilakukan namun air masih merembes ke jalan utama.',
            timeAgo: 'Diperbarui 1 hari lalu',
            buttonLabel: 'Lanjut Revisi',
            onActionPressed: () {},
            onCardTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
              );
            },
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildTaskCard(
            imageUrl: 'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?auto=format&fit=crop&q=80',
            title: 'Pohon Tumbang Telah Dievakuasi',
            category: 'Pengajar',
            description: 'Pohon yang menutupi jalan sepenuhnya telah berhasil dipotong dan dibersihkan dari bahu jalan.',
            timeAgo: 'Diselesaikan 3 hari lalu',
            buttonLabel: 'Lihat Detail',
            onActionPressed: () {},
            onCardTapped: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaskDetailScreen()),
              );
            },
          ),
        ],
      );
    }
  }

  Widget _buildTaskCard({
    required String imageUrl,
    required String title,
    required String category,
    required String description,
    required String timeAgo,
    required String buttonLabel,
    required VoidCallback onActionPressed,
    required VoidCallback onCardTapped,
  }) {
    return GestureDetector(
      onTap: onCardTapped,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F5F7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.category, size: 18, color: AppColors.inactive),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.inactive,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.subtext1,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        timeAgo,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.inactive,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onActionPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                        child: Text(
                          buttonLabel,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}