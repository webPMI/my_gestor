import 'package:flutter/material.dart';

import '../../components/module_form_card.dart';
import '../../components/my_textfield.dart';
import '../../localization/app_localizations.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ModuleFormCard(
        title: l10n.companyTitle,
        description: l10n.companyDescription,
        icon: Icons.business_rounded,
        actionLabel: l10n.formSave,
        onActionPressed: () {},
        children: [
          MyTextField(
            width: double.infinity,
            labelText: l10n.formReferenceLabel,
            hintText: l10n.companyNameHint,
            icon: Icons.apartment_rounded,
          ),
          MyTextField(
            width: double.infinity,
            labelText: l10n.formNotesLabel,
            hintText: l10n.formNotesHint,
            maxlines: 4,
            icon: Icons.info_outline_rounded,
          ),
        ],
      ),
    );
  }
}
