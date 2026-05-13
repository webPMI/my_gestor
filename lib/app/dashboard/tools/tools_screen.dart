import 'package:flutter/material.dart';

import '../../components/module_form_card.dart';
import '../../localization/app_localizations.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ModuleFormCard(
        title: l10n.toolsTitle,
        description: l10n.toolsDescription,
        icon: Icons.build_rounded,
        actionLabel: l10n.formSave,
        onActionPressed: () {},
        children: const [SizedBox(height: 180)],
      ),
    );
  }
}
