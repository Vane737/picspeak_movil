import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';


class MultiSelectTags extends StatefulWidget {
  final List<String> tags;
  final List<String> selectedTags;
  final ValueChanged<List<String>> onSelectionChanged;

  const MultiSelectTags({super.key, 
    required this.tags,
    required this.selectedTags,
    required this.onSelectionChanged,
  });

  @override
  MultiSelectTagsState createState() => MultiSelectTagsState();
}

class MultiSelectTagsState extends State<MultiSelectTags> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 12.0,
      children: widget.tags.map((tag) {
        final isSelected = widget.selectedTags.contains(tag);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                widget.selectedTags.remove(tag);
              } else {
                widget.selectedTags.add(tag);
              }
              widget.onSelectionChanged(widget.selectedTags);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.bgYellow : AppColors.bgGray,
              borderRadius: BorderRadius.circular(30.0), // Redondea las etiquetas
            ),
            child: Text(
              tag,
              style: AppFonts.smallTextStyle.copyWith(fontWeight: FontWeight.bold)
            ),
          ),
        );
      }).toList(),
    );
  }
}