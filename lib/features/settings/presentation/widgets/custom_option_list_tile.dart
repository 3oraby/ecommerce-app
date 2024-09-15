import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomOptionListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback? onTap;
  final Color tileColor;
  final EdgeInsets internalPadding;
  final TextStyle titleTextStyle;
  final Color leadingIconColor;
  final String? subTitle;
  final TextStyle subTitleTextStyle;

  const CustomOptionListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
    this.tileColor = Colors.white,
    this.internalPadding = LocalConstants.internalPadding,
    this.leadingIconColor = ThemeColors.primaryColor,
    this.subTitle,
    this.subTitleTextStyle = const TextStyle(
      fontSize: 18,
    ),
    this.titleTextStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: internalPadding,
      tileColor: tileColor,
      leading: Icon(leadingIcon, color: leadingIconColor),
      title: Text(
        title,
        style: titleTextStyle,
      ),
      subtitle: subTitle == null
          ? null
          : Text(
              subTitle!,
              style: subTitleTextStyle,
            ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 24,
      ),
      onTap: onTap,
    );
  }
}
