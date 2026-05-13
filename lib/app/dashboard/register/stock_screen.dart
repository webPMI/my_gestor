import 'package:flutter/material.dart';

import '../../components/module_form_card.dart';
import '../../components/my_textfield.dart';
import '../../localization/app_localizations.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ModuleFormCard(
        title: l10n.registerStockTitle,
        description: l10n.registerStockDescription,
        icon: Icons.inventory_2_rounded,
        actionLabel: l10n.formSave,
        onActionPressed: () {},
        children: [
          MyTextField(
            width: double.infinity,
            labelText: l10n.formReferenceLabel,
            hintText: l10n.formReferenceHint,
            icon: Icons.qr_code_rounded,
          ),
          MyTextField(
            width: double.infinity,
            labelText: l10n.formAmountLabel,
            hintText: l10n.formAmountHint,
            keyboardType: TextInputType.number,
            icon: Icons.inventory_rounded,
          ),
          MyTextField(
            width: double.infinity,
            labelText: l10n.formDateLabel,
            hintText: l10n.formDateHint,
            readOnly: true,
            icon: Icons.event_rounded,
          ),
          MyTextField(
            width: double.infinity,
            maxlines: 3,
            labelText: l10n.formNotesLabel,
            hintText: l10n.formNotesHint,
            icon: Icons.notes_rounded,
          ),
        ],
      ),
    );
  }
}
