import 'package:flutter/material.dart';
import 'models/detail_aspirasi_model.dart';
import 'widgets/detail_app_bar.dart';
import 'widgets/detail_header_section.dart';
import 'widgets/attachment_image_section.dart';
import 'widgets/aspiration_detail_card.dart';
import 'widgets/reported_location_card.dart';
import 'widgets/resolution_timeline_card.dart';
import 'widgets/official_response_card.dart';

class DetailAspirasiScreen extends StatelessWidget {
  /// Pass the real model from DaftarAspirasiScreen navigation.
  /// Falls back to dummy data if not provided.
  final DetailAspirasiModel? item;

  const DetailAspirasiScreen({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final data = item ?? dummyDetailAspirasi;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: const DetailAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header: category, ID, title, status ──────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            sliver: SliverToBoxAdapter(child: DetailHeaderSection(item: data)),
          ),

          // ── Attachment photo ─────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverToBoxAdapter(
              child: AttachmentImageSection(imageUrl: data.attachmentImagePath),
            ),
          ),

          // ── Aspiration details ────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverToBoxAdapter(
              child: AspirationDetailCard(description: data.detailDescription),
            ),
          ),

          // ── Reported location ─────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverToBoxAdapter(
              child: ReportedLocationCard(
                address: data.locationAddress,
                // TODO: Pass real LatLng from API response
              ),
            ),
          ),

          // ── Resolution timeline ───────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverToBoxAdapter(
              child: ResolutionTimelineCard(timeline: data.timeline),
            ),
          ),

          // ── Official response ─────────────────────────────────────────
          if (data.officialResponse != null)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(
                child: OfficialResponseCard(response: data.officialResponse!),
              ),
            ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}
