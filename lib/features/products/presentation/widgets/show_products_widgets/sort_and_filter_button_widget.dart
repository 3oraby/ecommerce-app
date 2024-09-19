import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class SortAndFilterButtonWidget extends StatelessWidget {
  const SortAndFilterButtonWidget({
    super.key,
    required this.onFilterTap,
    required this.onSortTap,
    required this.filterIsSelected,
  });

  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;
  final bool filterIsSelected;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: ThemeColors.primaryColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: onSortTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primaryColor,
                ),
                child: const Row(
                  children: [
                    Text(
                      'Sort',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.sort_sharp,
                      size: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              TextButton(
                onPressed: onFilterTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: Badge(
                  isLabelVisible: filterIsSelected,
                  label: const Icon(
                    Icons.brightness_1,
                    size: 1,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.filter_list,
                        size: 24,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
