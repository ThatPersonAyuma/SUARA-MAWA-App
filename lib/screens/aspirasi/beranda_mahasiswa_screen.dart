import 'package:flutter/material.dart';

class BerandaMahasiswaScreen extends StatelessWidget {
  const BerandaMahasiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildWelcomeHeader(),
                  const SizedBox(height: 24),
                  _buildStatusCards(),
                  const SizedBox(height: 16),
                  _buildSubmitBanner(),
                  const SizedBox(height: 28),
                  _buildRecentActivity(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          _buildFloatingActionButton(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF0F2F5),
      elevation: 0,
      leadingWidth: 60,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade300,
          child: ClipOval(
            child: Icon(Icons.person, color: Colors.grey.shade600, size: 24),
          ),
        ),
      ),
      title: const Text(
        'Serap Aspirasi',
        style: TextStyle(
          fontFamily: 'PublicSans',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Color(0xFF1A2B5F),
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(
            Icons.notifications_outlined,
            color: Colors.grey.shade700,
            size: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome back,\nStudent',
          style: TextStyle(
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w800,
            fontSize: 30,
            height: 1.2,
            color: Color(0xFF0D1B2A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Here's a summary of your recent feedback activity.",
          style: TextStyle(
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatusCard(
                label: 'Pending',
                count: 3,
                icon: Icons.assignment_late_outlined,
                backgroundColor: const Color(0xFFEDEEF2),
                textColor: const Color(0xFF0D1B2A),
                iconColor: const Color(0xFF5C6B8A),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatusCard(
                label: 'Processed',
                count: 1,
                icon: Icons.sync_outlined,
                backgroundColor: const Color(0xFFB2EBF2),
                textColor: const Color(0xFF00838F),
                iconColor: const Color(0xFF00838F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _StatusCard(
          label: 'Resolved',
          count: 12,
          icon: Icons.check_circle_outline,
          backgroundColor: const Color(0xFF1B4332),
          textColor: const Color(0xFF52B788),
          iconColor: const Color(0xFF52B788),
          isWide: true,
        ),
      ],
    );
  }

  Widget _buildSubmitBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B6E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.campaign_outlined,
              size: 110,
              color: Colors.white.withValues(alpha: 0.07),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Have something to say?',
                style: TextStyle(
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Submit your aspirations, complaints, or suggestions directly to the campus administration.',
                style: TextStyle(
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 16, color: Color(0xFF0D1B6E)),
                label: const Text(
                  'Submit Aspiration',
                  style: TextStyle(
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF0D1B6E),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontFamily: 'PublicSans',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xFF0D1B2A),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xFF5C6B8A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ActivityCard(
          iconBackgroundColor: const Color(0xFFB2EBF2),
          icon: Icons.build_outlined,
          iconColor: const Color(0xFF00838F),
          title: 'Broken AC in Room 302',
          timeAgo: '2h ago',
          description: 'The air conditioning unit in classroom ...',
          statusLabel: 'Pending Review',
          statusColor: const Color(0xFF5C6B8A),
          statusBgColor: const Color(0xFFEDEEF2),
          statusIcon: Icons.assignment_late_outlined,
        ),
        const SizedBox(height: 12),
        _ActivityCard(
          iconBackgroundColor: const Color(0xFF1B4332),
          icon: Icons.menu_book_outlined,
          iconColor: const Color(0xFF52B788),
          title: 'Library Extended Hours ...',
          timeAgo: 'Yesterday',
          description: 'Requesting extended library hours duri...',
          statusLabel: 'Processed',
          statusColor: const Color(0xFF00838F),
          statusBgColor: const Color(0xFFB2EBF2),
          statusIcon: Icons.sync_outlined,
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      bottom: 24,
      right: 20,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF1A2B5F),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A2B5F).withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(
          Icons.note_add_outlined,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                isActive: true,
                activeColor: const Color(0xFF0D1B6E),
              ),
              _NavItem(
                icon: Icons.history_rounded,
                label: 'History',
                isActive: false,
                activeColor: const Color(0xFF0D1B6E),
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                isActive: false,
                activeColor: const Color(0xFF0D1B6E),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── REUSABLE WIDGETS ───────────────────────────────────────────────────────

class _StatusCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final bool isWide;

  const _StatusCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: isWide ? _buildWideLayout() : _buildCompactLayout(),
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: iconColor, size: 22),
            Text(
              '$count',
              style: TextStyle(
                fontFamily: 'PublicSans',
                fontWeight: FontWeight.w800,
                fontSize: 28,
                color: textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWideLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'PublicSans',
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: textColor,
              ),
            ),
          ],
        ),
        Text(
          '$count',
          style: TextStyle(
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w800,
            fontSize: 32,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final Color iconBackgroundColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String timeAgo;
  final String description;
  final String statusLabel;
  final Color statusColor;
  final Color statusBgColor;
  final IconData statusIcon;

  const _ActivityCard({
    required this.iconBackgroundColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.timeAgo,
    required this.description,
    required this.statusLabel,
    required this.statusColor,
    required this.statusBgColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF0D1B2A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, color: statusColor, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        statusLabel,
                        style: TextStyle(
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : Colors.grey.shade500;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'PublicSans',
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            fontSize: 11,
            color: color,
          ),
        ),
      ],
    );
  }
}
