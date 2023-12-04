import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';

class SelectedTagsDisplay extends StatelessWidget {
  final List<String> selectedTags;

  const SelectedTagsDisplay({
    Key? key,
    required this.selectedTags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 12.0,
      children: selectedTags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.bgYellow,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            tag,
            style: AppFonts.smallTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}