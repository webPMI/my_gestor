// Tests de widget para AppRoutes y constantes de rutas.

import 'package:flutter_test/flutter_test.dart';
import 'package:my_gestor/app/utils/app_routes.dart';

void main() {
  group('AppRoutes —', () {
    test('home es /', () => expect(AppRoutes.home, '/'));
    test('login es /login', () => expect(AppRoutes.login, '/login'));
    test('company es /company', () => expect(AppRoutes.company, '/company'));
    test(
      'register es /register',
      () => expect(AppRoutes.register, '/register'),
    );
    test('stats es /stats', () => expect(AppRoutes.stats, '/stats'));
    test('profile es /profile', () => expect(AppRoutes.profile, '/profile'));
    test('tools es /tools', () => expect(AppRoutes.tools, '/tools'));

    test('todas las rutas comienzan con /', () {
      final routes = [
        AppRoutes.home,
        AppRoutes.login,
        AppRoutes.company,
        AppRoutes.register,
        AppRoutes.stats,
        AppRoutes.profile,
        AppRoutes.tools,
      ];
      for (final r in routes) {
        expect(r.startsWith('/'), isTrue, reason: '$r debe empezar con /');
      }
    });
  });
}
