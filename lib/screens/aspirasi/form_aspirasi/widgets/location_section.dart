import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../components/section_card.dart';

class LocationSection extends StatefulWidget {
  final LatLng? selectedLocation;
  final VoidCallback? onUseCurrentGps;

  const LocationSection({
    super.key,
    this.selectedLocation,
    this.onUseCurrentGps,
  });

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  // Default: center of Jember, East Java
  static const LatLng _defaultCenter = LatLng(-8.1845, 113.6720);

  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  LatLng get _center => widget.selectedLocation ?? _defaultCenter;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: Icons.location_on_outlined,
      title: 'Location',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 180,
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _center,
                      initialZoom: 15,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.suara_mawa',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _center,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_pin,
                              color: Color(0xFF1A2B5F),
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: _GpsButton(onPressed: widget.onUseCurrentGps),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Pinpoint the exact location of the observation.',
            style: TextStyle(
              fontFamily: 'PublicSans',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _GpsButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _GpsButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.my_location_rounded, size: 16, color: Color(0xFF1A2B5F)),
            SizedBox(width: 6),
            Text(
              'Use Current GPS',
              style: TextStyle(
                fontFamily: 'PublicSans',
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF1A2B5F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
