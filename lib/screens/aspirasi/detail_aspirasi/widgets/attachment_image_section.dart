import 'package:flutter/material.dart';

class AttachmentImageSection extends StatelessWidget {
  /// Pass a network URL, asset path, or null to show a placeholder.
  final String? imageUrl;

  const AttachmentImageSection({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _Placeholder(),
              )
            : _Placeholder(),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A2B3C),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Simulated road crack texture via gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2C3E50),
                  Color(0xFF1A252F),
                  Color(0xFF2C3E50),
                ],
              ),
            ),
          ),
          Icon(
            Icons.image_outlined,
            size: 48,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          Positioned(
            bottom: 12,
            child: Text(
              'Attachment photo',
              style: TextStyle(
                fontFamily: 'PublicSans',
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
