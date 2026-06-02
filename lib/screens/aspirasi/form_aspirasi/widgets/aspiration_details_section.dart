import 'package:flutter/material.dart';
import '../components/section_card.dart';
import '../components/form_field_label.dart';

const List<String> _categories = [
  'Fasilitas Kampus',
  'Akademik',
  'Kemahasiswaan',
  'Layanan Administrasi',
  'Keamanan',
  'Lainnya',
];

class AspirationDetailsSection extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ValueChanged<String?> onCategoryChanged;
  final String? selectedCategory;

  const AspirationDetailsSection({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onCategoryChanged,
    required this.selectedCategory,
  });

  @override
  State<AspirationDetailsSection> createState() =>
      _AspirationDetailsSectionState();
}

class _AspirationDetailsSectionState extends State<AspirationDetailsSection> {
  static const _inputDecoration = InputDecoration(
    filled: true,
    fillColor: Color(0xFFF8F9FB),
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFFDDE1EA)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFFDDE1EA)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFF1A2B5F), width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.redAccent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: Icons.article_outlined,
      title: 'Aspiration Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormFieldLabel(label: 'Title'),
          TextFormField(
            controller: widget.titleController,
            style: const TextStyle(
              fontFamily: 'PublicSans',
              fontSize: 14,
              color: Color(0xFF0D1B2A),
            ),
            decoration: _inputDecoration.copyWith(
              hintText: 'Brief summary of the issue',
              hintStyle: TextStyle(
                fontFamily: 'PublicSans',
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Title cannot be empty';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          const FormFieldLabel(label: 'Category'),
          DropdownButtonFormField<String>(
            value: widget.selectedCategory,
            onChanged: widget.onCategoryChanged,
            hint: Text(
              'Select a category',
              style: TextStyle(
                fontFamily: 'PublicSans',
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF1A2B5F),
            ),
            style: const TextStyle(
              fontFamily: 'PublicSans',
              fontSize: 14,
              color: Color(0xFF0D1B2A),
            ),
            decoration: _inputDecoration.copyWith(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 4,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a category';
              }
              return null;
            },
            items: _categories
                .map(
                  (category) =>
                      DropdownMenuItem(value: category, child: Text(category)),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          const FormFieldLabel(label: 'Description'),
          TextFormField(
            controller: widget.descriptionController,
            maxLines: 5,
            style: const TextStyle(
              fontFamily: 'PublicSans',
              fontSize: 14,
              color: Color(0xFF0D1B2A),
            ),
            decoration: _inputDecoration.copyWith(
              hintText: 'Please provide more details here...',
              hintStyle: TextStyle(
                fontFamily: 'PublicSans',
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
              contentPadding: const EdgeInsets.all(14),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Description cannot be empty';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
