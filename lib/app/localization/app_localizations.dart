import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('es'), Locale('en')];

  static const delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    assert(
      localizations != null,
      'AppLocalizations is not available in this context.',
    );
    return localizations!;
  }

  bool get _isEnglish => locale.languageCode == 'en';

  String _t(String spanish, String english) => _isEnglish ? english : spanish;

  String get appTitle => 'My Gestor';
  String get homeBadge => _t(
    'Plataforma contable Material 3 para equipos modernos',
    'Material 3 accounting platform for modern teams',
  );
  String get homeHeadline => _t(
    'Gestión contable clara, rápida y moderna.',
    'Clear, fast and modern accounting management.',
  );
  String get homeBody => _t(
    'My Gestor te ayuda a organizar empresas, registros y operaciones financieras desde una interfaz limpia y escalable.',
    'My Gestor helps you organize companies, records and financial operations from a clean and scalable interface.',
  );
  String get homeFeatureCompanies => _t('Empresas', 'Companies');
  String get homeFeatureRecords => _t('Registros', 'Records');
  String get homeFeatureReports => _t('Reportes', 'Reports');
  String get homeFeatureTools => _t('Herramientas', 'Tools');
  String get homeCtaOpenPlatform => _t('Abrir plataforma', 'Open platform');
  String get homeCtaViewExperience => _t('Ver experiencia', 'View experience');
  String get homePanelTitle =>
      _t('Panel financiero inteligente', 'Smart financial panel');
  String get homeMetricMonthlyFlowTitle => _t('Flujo mensual', 'Monthly flow');
  String get homeMetricMonthlyFlowCaption => _t(
    'comparado con el cierre anterior',
    'compared with the previous close',
  );
  String get homeMetricOperationsTitle =>
      _t('Operaciones conciliadas', 'Reconciled operations');
  String get homeMetricOperationsCaption =>
      _t('con seguimiento en tiempo real', 'with real-time tracking');
  String get homeMetricAlertsTitle =>
      _t('Alertas resueltas', 'Alerts resolved');
  String get homeMetricAlertsCaption =>
      _t('con flujos más rápidos', 'with faster workflows');

  String get navTitle => _t('Navegación', 'Navigation');
  String get navSubtitle =>
      _t('Accesos rápidos del gestor', 'Quick access to the manager');
  String get navCompany => _t('Empresa', 'Company');
  String get navRegisters => _t('Registros', 'Registers');
  String get navGraphics => _t('Gráficos', 'Charts');
  String get navProfile => _t('Perfil', 'Profile');
  String get navTools => _t('Herramientas', 'Tools');

  String get loginTitle => _t('Ingresar', 'Sign in');
  String get loginDescription => _t(
    'Accedé a My Gestor con una interfaz más clara, rápida y moderna.',
    'Access My Gestor with a clearer, faster and more modern interface.',
  );
  String get loginEmailLabel => _t('Correo', 'Email');
  String get loginEmailHint => _t('tu@email.com', 'you@example.com');
  String get loginPasswordLabel => _t('Contraseña', 'Password');
  String get loginPasswordHint => _t('Ingresa tu clave', 'Enter your password');
  String get loginRememberMe => _t('Recordarme', 'Remember me');
  String get loginForgotPassword =>
      _t('¿Olvidaste tu clave?', 'Forgot password?');
  String get loginSubmit => _t('Entrar al panel', 'Enter dashboard');
  String get loginBackHome => _t('Volver al inicio', 'Back to home');
  String get loginEmailRequired =>
      _t('Ingresá un correo válido.', 'Please enter a valid email address.');
  String get loginPasswordRequired =>
      _t('Ingresá tu contraseña.', 'Please enter your password.');
  String get loginConfirmPasswordLabel =>
      _t('Confirmar contraseña', 'Confirm password');
  String get loginConfirmPasswordHint =>
      _t('Repetí tu contraseña', 'Repeat your password');
  String get loginConfirmPasswordRequired =>
      _t('Las contraseñas no coinciden.', 'Passwords do not match.');
  String get loginModeSignIn => _t('Ingresar', 'Sign in');
  String get loginModeSignUp => _t('Crear cuenta', 'Create account');
  String get loginGoogle => _t('Continuar con Google', 'Continue with Google');
  String get loginOrContinue => _t('o continuá con', 'or continue with');
  String get loginBackendMissing => _t(
    'Configura Firebase para habilitar el acceso.',
    'Configure Firebase to enable access.',
  );

  String get loginSupabaseOptional => _t(
    'Supabase no esta configurado. El acceso funciona, pero la sincronizacion de perfiles queda desactivada.',
    'Supabase is not configured. Sign-in works, but profile sync is disabled.',
  );
  String get loginAuthError =>
      _t('No se pudo completar el acceso.', 'Could not complete sign-in.');
  String get logout => _t('Cerrar sesión', 'Sign out');
  String get backendNotConfigured =>
      _t('Backend no configurado todavía.', 'Backend is not configured yet.');

  String get registerSalesTab => _t('Ventas', 'Sales');
  String get registerPurchasesTab => _t('Compras', 'Purchases');
  String get registerStockTab => _t('Stock', 'Stock');
  String get registerSalesTitle => _t('Alta de ventas', 'Sales entry');
  String get registerSalesDescription => _t(
    'Registrá ventas ingresadas y mantené actualizado el flujo mensual.',
    'Register incoming sales and keep the monthly flow up to date.',
  );
  String get registerPurchasesTitle => _t('Alta de compras', 'Purchase entry');
  String get registerPurchasesDescription => _t(
    'Seguimiento de facturas de proveedores y costos de ingreso.',
    'Track supplier invoices and incoming costs.',
  );
  String get registerStockTitle => _t('Movimiento de stock', 'Stock movement');
  String get registerStockDescription => _t(
    'Controlá los movimientos de inventario y la cantidad disponible.',
    'Control inventory movements and available quantity.',
  );

  String get formReferenceLabel => _t('Referencia', 'Reference');
  String get formReferenceHint =>
      _t('Número de operación o documento', 'Operation or document number');
  String get formAmountLabel => _t('Importe', 'Amount');
  String get formAmountHint => _t('0,00', '0.00');
  String get formDateLabel => _t('Fecha', 'Date');
  String get formDateHint => _t('Seleccioná una fecha', 'Select a date');
  String get formNotesLabel => _t('Notas', 'Notes');
  String get formNotesHint => _t('Notas opcionales', 'Optional notes');
  String get formSave => _t('Guardar registro', 'Save record');

  String get companyTitle => _t('Empresa', 'Company');
  String get companyDescription => _t(
    'Administrá el perfil de la empresa, datos fiscales y configuración general.',
    'Manage company profile, tax data and general configuration.',
  );
  String get companyNameHint => _t('My Gestor S.A.', 'My Gestor Ltd.');
  String get statsTitle => _t('Estadísticas', 'Statistics');
  String get statsDescription => _t(
    'Revisá métricas operativas y tendencias de rendimiento.',
    'Review operational metrics and performance trends.',
  );
  String get profileTitle => _t('Perfil', 'Profile');
  String get profileDescription => _t(
    'Ajustá tu información de usuario y preferencias.',
    'Adjust your user information and preferences.',
  );
  String get toolsTitle => _t('Herramientas', 'Tools');
  String get toolsDescription => _t(
    'Usá utilidades para automatizar tareas contables frecuentes.',
    'Use utilities to automate frequent accounting tasks.',
  );
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
