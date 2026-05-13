# Arquitectura — My Gestor

## Stack

| Capa | Tecnología |
|------|-----------|
| UI | Flutter · Material 3 · GoRouter |
| Auth | Firebase Auth · Google Sign-In |
| Base de datos principal | Cloud Firestore |
| Perfil de usuario | Supabase (tabla `profiles`) |
| Localización | AppLocalizations custom (ES / EN) |
| Tema | AppTheme (Material 3 seed color `#0F4C81`) |

---

## Estructura de carpetas

```
lib/
├── main.dart                    # Bootstrap: BackendBootstrap → AuthService → runApp
└── app/
    ├── auth/
    │   └── auth_service.dart    # Singleton ChangeNotifier; Firebase + Google + Supabase sync
    ├── backend/
    │   └── backend_bootstrap.dart  # Firebase.initializeApp + Supabase.initialize
    ├── config/
    │   └── backend_config.dart  # Lectores de String.fromEnvironment
    ├── components/              # Widgets reutilizables
    │   ├── module_form_card.dart
    │   ├── my_button.dart
    │   ├── my_drawer.dart
    │   ├── my_tab.dart
    │   └── my_textfield.dart
    ├── dashboard/               # Pantallas protegidas (requieren auth)
    │   ├── dashboard.dart       # ShellRoute scaffold con MyDrawer
    │   ├── company/
    │   ├── profile/
    │   ├── register/
    │   │   ├── sales/
    │   │   ├── pucharses_screen.dart
    │   │   └── stock_screen.dart
    │   ├── stats/
    │   └── tools/
    ├── localization/
    │   ├── app_language.dart    # flutter_localizations delegates + defaultLocale
    │   └── app_localizations.dart  # Delegate custom con getters ES/EN
    ├── public/                  # Pantallas sin auth
    │   ├── home_page.dart
    │   └── login.dart
    ├── theme/
    │   └── app_theme.dart       # ThemeData Material 3
    └── utils/
        ├── app_metadata.dart    # Constantes de marca
        ├── app_routes.dart      # Constantes de rutas
        └── routes.dart          # GoRouter + redirect por auth
```

---

## Flujo de arranque

```
main()
  └─ WidgetsFlutterBinding.ensureInitialized()
  └─ BackendBootstrap.initialize()
       ├─ Firebase.initializeApp()   (si FIREBASE_* env vars presentes)
       └─ Supabase.initialize()      (si SUPABASE_* env vars presentes)
  └─ authService.initialize()
       ├─ GoogleSignIn.instance.initialize()  (si GOOGLE_CLIENT_ID presente)
       └─ FirebaseAuth.instance.authStateChanges().listen(...)
  └─ runApp(MyApp)
```

---

## Flujo de autenticación

```
Usuario no autenticado
  ├─ / (HomePage)  → acceso libre
  └─ /login        → acceso libre
       ├─ Email/Password  → FirebaseAuth.signInWithEmailAndPassword
       ├─ Registro        → FirebaseAuth.createUserWithEmailAndPassword
       └─ Google (web)    → renderButton() de google_sign_in_web
            └── (móvil)   → GoogleSignIn.instance.authenticate()
                             └─ Firebase credential → signInWithCredential
                                  ├─ _syncFirestoreUser()   → colección 'users'
                                  └─ _syncSupabaseProfile() → tabla 'profiles'

Usuario autenticado
  └─ GoRouter redirect → /company (dashboard)
       ├─ /company
       ├─ /register
       ├─ /stats
       ├─ /profile
       └─ /tools
```

---

## Variables de entorno requeridas

Ver `docs/deploy.md` para instrucciones de configuración.

| Variable | Descripción |
|----------|-------------|
| `FIREBASE_API_KEY` | API key del proyecto Firebase |
| `FIREBASE_APP_ID` | App ID del proyecto Firebase |
| `FIREBASE_MESSAGING_SENDER_ID` | Sender ID de FCM |
| `FIREBASE_PROJECT_ID` | ID del proyecto Firebase |
| `FIREBASE_AUTH_DOMAIN` | Dominio de auth (opcional) |
| `FIREBASE_STORAGE_BUCKET` | Bucket de storage (opcional) |
| `FIREBASE_MEASUREMENT_ID` | ID de Analytics (opcional) |
| `GOOGLE_CLIENT_ID` | OAuth Client ID para Google Sign-In |
| `SUPABASE_URL` | URL del proyecto Supabase |
| `SUPABASE_ANON_KEY` | Anon key pública de Supabase |
