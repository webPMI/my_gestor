import 'package:flutter/material.dart';

import '../../components/module_form_card.dart';
import '../../localization/app_localizations.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ModuleFormCard(
        title: l10n.statsTitle,
        description: l10n.statsDescription,
        icon: Icons.query_stats_rounded,
        actionLabel: l10n.formSave,
        onActionPressed: () {},
        children: const [SizedBox(height: 180)],
      ),
    );
  }
}
