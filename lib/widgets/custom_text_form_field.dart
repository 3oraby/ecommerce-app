
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.labelText,
    this.fillColor = Colors.grey,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.enabledBorderColor = Colors.black,
    this.enabledBorderWidth = 1,
    this.hintText,
    this.onChanged,
    this.validator,
    this.textStyle,
    this.hintStyle,
    this.labelStyle = const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontStyle: FontStyle.italic,
    ),
    this.onTap,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
  });

  final String labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final bool isObscure;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color borderColor;
  final double borderWidth;
  final Color enabledBorderColor;
  final double enabledBorderWidth;

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _isObscure,
      validator: widget.validator,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      style: widget.textStyle,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.labelText == "password"
            ? IconButton(
                icon: _isObscure
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                iconSize: 30,
              )
            : widget.suffixIcon,
        contentPadding: const EdgeInsets.all(25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.enabledBorderColor,
            width: widget.enabledBorderWidth,
          ),
        ),
        filled: true,
        fillColor: widget.fillColor,
        labelStyle: widget.labelStyle,
      ),
    );
  }
}
