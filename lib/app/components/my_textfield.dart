import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onEditingComplete,
    this.icon,
    this.validator,
    this.onChanged,
    this.padding,
    this.obscureText,
    this.sufIcon,
    this.margin,
    this.onTap,
    this.readOnly,
    this.labelText,
    this.maxlines,
    this.width,
    this.height,
    this.keyboardType,
  });

  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final IconData? icon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double? padding;
  final bool? obscureText;
  final Widget? sufIcon;
  final double? margin, width, height;
  final void Function()? onTap;
  final bool? readOnly;
  final String? labelText;
  final int? maxlines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(margin ?? 5),
      padding: EdgeInsets.all(padding ?? 0),
      child: TextFormField(
        maxLines: maxlines ?? 1,
        onTap: onTap,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: sufIcon,
          prefixIcon: icon != null ? Icon(icon) : null,
          hintText: hintText,
          filled: true,
          fillColor: colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: colorScheme.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        controller: controller,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
