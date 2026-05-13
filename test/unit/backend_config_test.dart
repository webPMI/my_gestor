// Tests unitarios para BackendConfig.
// No requieren Firebase ni Supabase reales porque todo viene de String.fromEnvironment,
// que en test queda vacío (sin --dart-define) → flags de "no configurado".

import 'package:flutter_test/flutter_test.dart';
import 'package:my_gestor/app/config/backend_config.dart';

void main() {
  group('BackendConfig —', () {
    test('hasFirebase es false cuando no hay dart-define', () {
      expect(BackendConfig.hasFirebase, isFalse);
    });

    test('hasSupabase es false cuando no hay dart-define', () {
      expect(BackendConfig.hasSupabase, isFalse);
    });

    test('hasGoogleClientId es false cuando no hay dart-define', () {
      expect(BackendConfig.hasGoogleClientId, isFalse);
    });

    test('firebaseOptions retorna null cuando no hay configuración', () {
      expect(BackendConfig.firebaseOptions, isNull);
    });

    test('constantes de entorno vacías son String vacíos', () {
      expect(BackendConfig.firebaseApiKey, isEmpty);
      expect(BackendConfig.supabaseUrl, isEmpty);
      expect(BackendConfig.googleClientId, isEmpty);
    });
  });
}
