import 'package:flutter/material.dart';

class DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF0F2F5),
      elevation: 0,
      leadingWidth: 48,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1A2B5F),
            size: 22,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, color: Colors.grey.shade600, size: 16),
          ),
          const SizedBox(width: 8),
          const Text(
            'Serap Aspirasi',
            style: TextStyle(
              fontFamily: 'PublicSans',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xFF1A2B5F),
            ),
          ),
        ],
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
}
