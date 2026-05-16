import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app/backend/backend_bootstrap.dart';
import 'app/layout/app_layout_scope.dart';
import 'app/localization/app_localizations.dart';
import 'app/localization/app_language.dart';
import 'app/theme/app_theme.dart';
import 'app/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackendBootstrap.initialize();
  await authService.initialize();
  runApp(const MyApp());
}

/// Habilita scroll con mouse y trackpad en Flutter web / Linux desktop.
class _DesktopScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...AppLanguage.localizationsDelegates,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return AppLanguage.defaultLocale;
        }

        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }

        return AppLanguage.defaultLocale;
      },
      routerConfig: router,
      builder: (context, child) {
        if (child == null) {
          return const SizedBox.shrink();
        }
        return AppLayoutProvider(child: child);
      },
      scrollBehavior: _DesktopScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
    );
  }
}
