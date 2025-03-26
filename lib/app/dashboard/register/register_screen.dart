import 'package:flutter/material.dart';
import 'package:my_gestor/app/components/my_tab.dart';

import 'pucharses_screen.dart';
import 'sales/sales.dart';
import 'stock_screen.dart';

class RegisterScreen extends StatelessWidget {
const RegisterScreen({ super.key });

  @override
  Widget build(BuildContext context){
    return MyTab(
      tabs: {
        'Sales': const SalesScreen(),
        'Purchases': const PurchasesScreen(),
        'Stock': const StockScreen(),
      },);
  }
}