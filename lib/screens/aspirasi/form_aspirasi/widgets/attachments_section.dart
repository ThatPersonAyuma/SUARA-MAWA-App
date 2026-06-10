import 'package:flutter/material.dart';
import '../components/section_card.dart';
import '../components/attachment_button.dart';

class AttachmentsSection extends StatelessWidget {
  final VoidCallback? onTakePhoto;
  final VoidCallback? onUploadGallery;

  const AttachmentsSection({super.key, this.onTakePhoto, this.onUploadGallery});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: Icons.attach_file_rounded,
      title: 'Attachments',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AttachmentButton(
            icon: Icons.camera_alt_outlined,
            label: 'Take Photo',
            onPressed: onTakePhoto,
          ),
          const SizedBox(height: 10),
          AttachmentButton(
            icon: Icons.image_outlined,
            label: 'Upload Gallery',
            onPressed: onUploadGallery,
          ),
          const SizedBox(height: 10),
          Text(
            'Supported formats: JPG, PNG. Max size: 5MB.',
            style: TextStyle(
              fontFamily: 'PublicSans',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
