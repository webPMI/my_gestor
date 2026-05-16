import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Conditional import: web usa GIS real; VM/nativo usa stub para evitar dart:ui_web en tests.
import '../public/google_button_stub.dart'
    if (dart.library.js_interop) 'package:google_sign_in_web/web_only.dart'
    as google_sign_in_web;

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  final String label;
  final Future<void> Function() onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 480;
        final width = isCompact ? double.infinity : 360.0;

        if (kIsWeb) {
          return Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: width,
              child: IgnorePointer(
                ignoring: loading,
                child: Opacity(
                  opacity: loading ? 0.6 : 1,
                  child: google_sign_in_web.renderButton(),
                ),
              ),
            ),
          );
        }

        return Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: width,
            child: FilledButton.tonalIcon(
              onPressed: loading ? null : () => onPressed(),
              icon: const Icon(Icons.g_mobiledata_rounded),
              label: Text(label),
            ),
          ),
        );
      },
    );
  }
}
