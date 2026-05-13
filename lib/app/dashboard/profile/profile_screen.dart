import 'package:flutter/material.dart';

import '../../components/module_form_card.dart';
import '../../components/my_textfield.dart';
import '../../localization/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ModuleFormCard(
        title: l10n.profileTitle,
        description: l10n.profileDescription,
        icon: Icons.person_rounded,
        actionLabel: l10n.formSave,
        onActionPressed: () {},
        children: [
          MyTextField(
            width: double.infinity,
            labelText: l10n.loginEmailLabel,
            hintText: l10n.loginEmailHint,
            icon: Icons.alternate_email_rounded,
          ),
          MyTextField(
            width: double.infinity,
            labelText: l10n.loginPasswordLabel,
            hintText: l10n.loginPasswordHint,
            obscureText: true,
            icon: Icons.password_rounded,
          ),
        ],
      ),
    );
  }
}
