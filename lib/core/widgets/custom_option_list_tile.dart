import 'package:e_commerce_app/constants/local_constants.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomOptionListTile extends StatelessWidget {
  final String? title;
  final IconData? leadingIcon;
  final VoidCallback? onTap;
  final Color tileColor;
  final EdgeInsets internalPadding;
  final TextStyle titleTextStyle;
  final Color leadingIconColor;
  final String? subTitle;
  final TextStyle subTitleTextStyle;
  final Widget? leadingWidget;
  final bool showLeadingWidget;
  final bool isThreeLine;
  final Icon? trailingIcon;

  const CustomOptionListTile({
    super.key,
    this.title,
    this.leadingIcon,
    this.onTap,
    this.tileColor = Colors.white,
    this.internalPadding = LocalConstants.internalPadding,
    this.leadingIconColor = ThemeColors.primaryColor,
    this.subTitle,
    this.subTitleTextStyle = const TextStyle(
      fontSize: 18,
    ),
    this.titleTextStyle = const TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),
    this.leadingWidget,
    this.showLeadingWidget = true,
    this.isThreeLine = false,
    this.trailingIcon = const Icon(
      Icons.arrow_forward_ios,
      size: 24,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: internalPadding,
      tileColor: tileColor,
      leading: showLeadingWidget
          ? leadingWidget ?? Icon(leadingIcon, color: leadingIconColor)
          : null,
      title: Text(
        title ?? "",
        style: titleTextStyle,
      ),
      isThreeLine: isThreeLine,
      subtitle: subTitle == null
          ? null
          : Text(
              subTitle!,
              style: subTitleTextStyle,
            ),
      trailing: trailingIcon,
      onTap: onTap,
    );
  }
}
