// Tests de widget para las pantallas públicas (Login).
// HomePage se omite aquí porque su layout con Expanded requiere tests de integración.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:my_gestor/app/localization/app_language.dart';
import 'package:my_gestor/app/localization/app_localizations.dart';
import 'package:my_gestor/app/theme/app_theme.dart';
import 'package:my_gestor/app/public/login.dart';
import 'package:my_gestor/app/utils/app_routes.dart';

// Helper: envuelve un widget en un router mínimo con localización, tema y surface fijo.
Widget _wrap(WidgetTester tester, Widget child) {
  tester.view.physicalSize = const Size(1080, 1920);
  tester.view.devicePixelRatio = 1.0;
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const Scaffold(),
      ),
    ],
  );

  return MaterialApp.router(
    routerConfig: router,
    localizationsDelegates: [
      AppLocalizations.delegate,
      ...AppLanguage.localizationsDelegates,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light,
  );
}

void main() {
  tearDown(() {
    // Restaurar superficie por defecto tras cada test
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.clearAllTestValues();
  });

  group('Login —', () {
    testWidgets('se renderiza sin errores', (tester) async {
      await tester.pumpWidget(_wrap(tester, const Login()));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('tiene campo de email y contraseña', (tester) async {
      await tester.pumpWidget(_wrap(tester, const Login()));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
    });

    testWidgets('muestra opciones de modo (iniciar / registrarse)', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(tester, const Login()));
      await tester.pumpAndSettle();
      final segmentedButtons = find.byWidgetPredicate(
        (w) => w.runtimeType.toString().startsWith('SegmentedButton'),
      );
      expect(segmentedButtons, findsAtLeastNWidgets(1));
    });

    testWidgets('tiene campos de email y contraseña', (tester) async {
      await tester.pumpWidget(_wrap(tester, const Login()));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
    });
  });
}
