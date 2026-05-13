import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.text,
    this.onPressed,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.icon,
    this.isPrimary = true,
  });

  final String? text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? padding;
  final double? margin;
  final IconData? icon;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final buttonStyle = FilledButton.styleFrom(
      minimumSize: Size(width ?? 0, height ?? 56),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      backgroundColor: isPrimary
          ? colorScheme.primary
          : colorScheme.secondaryContainer,
      foregroundColor: isPrimary
          ? colorScheme.onPrimary
          : colorScheme.onSecondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding ?? 0),
      margin: EdgeInsets.all(margin ?? 0),
      child: FilledButton.icon(
        onPressed: onPressed,
        style: buttonStyle,
        icon: Icon(icon ?? Icons.arrow_forward_rounded),
        label: Text(
          text ?? 'Enter',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
