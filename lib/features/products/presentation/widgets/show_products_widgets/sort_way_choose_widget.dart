import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class SortWayChooseWidget extends StatelessWidget {
  const SortWayChooseWidget({
    super.key,
    required this.description,
    required this.onTap,
    this.isSelected = false,
  });

  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        description,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: ThemeColors.primaryColor)
          : const Icon(Icons.circle_outlined, color: ThemeColors.unEnabledColor),
      onTap: onTap,
    );
  }
}
