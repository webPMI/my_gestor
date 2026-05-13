// Tests de widget para AppMetadata.

import 'package:flutter_test/flutter_test.dart';
import 'package:my_gestor/app/utils/app_metadata.dart';

void main() {
  group('AppMetadata —', () {
    test('appName no es vacío', () => expect(AppMetadata.appName, isNotEmpty));
    test('companyName contiene Servicio Web PMI', () {
      expect(AppMetadata.companyName, contains('Servicio Web PMI'));
    });
    test('ownerName contiene Exequiel Paez', () {
      expect(AppMetadata.ownerName, contains('Exequiel Paez'));
    });
    test('shortDescription no es vacío', () {
      expect(AppMetadata.shortDescription, isNotEmpty);
    });
    test('landingHeadline no es vacío', () {
      expect(AppMetadata.landingHeadline, isNotEmpty);
    });
  });
}
