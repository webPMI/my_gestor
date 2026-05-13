import 'package:flutter/material.dart';

import 'package:my_gestor/app/components/my_tab.dart';

import '../../localization/app_localizations.dart';

import 'pucharses_screen.dart';
import 'sales/sales.dart';
import 'stock_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return MyTab(
      tabs: {
        l10n.registerSalesTab: const SalesScreen(),
        l10n.registerPurchasesTab: const PurchasesScreen(),
        l10n.registerStockTab: const StockScreen(),
      },
    );
  }
}
