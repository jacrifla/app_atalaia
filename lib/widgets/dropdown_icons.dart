import 'package:flutter/material.dart';

class IconDropdownOptions {
  static Widget buildDropdown({
    required IconData value,
    required void Function(IconData?) onChanged,
  }) {
    List<IconData> uniqueIcons = icons.toSet().toList();

    if (!uniqueIcons.contains(value)) {
      uniqueIcons.add(value);
    }

    return DropdownButton<IconData>(
      value: value,
      onChanged: onChanged,
      items: uniqueIcons.map((icon) {
        return DropdownMenuItem<IconData>(
          value: icon,
          child: Icon(icon),
        );
      }).toList(),
    );
  }

  static List<IconData> icons = [
    Icons.home_outlined,
    Icons.living_rounded,
    Icons.kitchen_outlined,
    Icons.dry_cleaning_outlined,
    Icons.clean_hands_outlined,
    Icons.bathtub_outlined,
    Icons.bed_outlined,
    Icons.chair_outlined,
    Icons.lightbulb_outlined,
    Icons.tv_outlined,
    Icons.speaker_outlined,
    Icons.door_sliding_outlined,
    Icons.window_outlined,
    Icons.air_outlined,
    Icons.fireplace_outlined,
    Icons.garage_outlined,
    Icons.stairs_outlined,
    Icons.plumbing_outlined,
  ];
}
