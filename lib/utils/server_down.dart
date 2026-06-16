import 'package:flutter/material.dart';

const kNavy = Color(0xFF1A2C5B);
const kTeal = Color(0xFF4DD0C4);
const kRed  = Color(0xFFE53935);
const kBg   = Color(0xFFF5F6FA);

class ServerDownPage extends StatelessWidget {
  final VoidCallback onRetry;
  const ServerDownPage({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                width: 120, height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8ECF5),
                  shape: BoxShape.circle,
                ),
                child: Stack(alignment: Alignment.center, children: [
                  const Icon(Icons.dns_outlined, size: 56, color: Color(0xFFBDBDBD)),
                  Positioned(bottom: 22, right: 22,
                    child: Container(
                      width: 28, height: 28,
                      decoration: const BoxDecoration(
                          color: Color(0xFFFF6F00),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.warning_amber_rounded,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 28),
              const Text('Server Sedang Down',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: kNavy),
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(
                'Maaf, server kami sedang tidak dapat dijangkau. Tim kami sedang bekerja untuk memperbaikinya.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500, height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_outlined, size: 18),
                  label: const Text('Coba Lagi',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kNavy, foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}