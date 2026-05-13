# TODO — My Gestor (Servicio Web PMI)

Estado actual: **MVP funcional · build web limpio · análisis limpio**

---

## 🔴 Crítico / Bloqueante

- [ ] Configurar variables de entorno de Firebase en el servidor/CI antes del primer deploy real
  - `FIREBASE_API_KEY`, `FIREBASE_APP_ID`, `FIREBASE_MESSAGING_SENDER_ID`
  - `FIREBASE_PROJECT_ID`, `FIREBASE_AUTH_DOMAIN`, `FIREBASE_STORAGE_BUCKET`
  - `GOOGLE_CLIENT_ID`
- [ ] Configurar variables de entorno de Supabase: `SUPABASE_URL`, `SUPABASE_ANON_KEY`
- [ ] Habilitar autenticación por email/contraseña y Google en la consola de Firebase
- [ ] Crear tabla `profiles` en Supabase con el schema documentado en `docs/supabase.md`
- [ ] Agregar `<meta name="google-signin-client_id" ...>` en `web/index.html` para el botón Google web

---

## 🟠 Alta prioridad

### Auth
- [ ] Implementar pantalla de "Olvidé mi contraseña" (botón presente, acción vacía en `login.dart`)
- [ ] Validar que el redirect post-login apunta al dashboard correcto según el rol del usuario
- [ ] Añadir manejo de errores específicos de `FirebaseAuthException` (código `user-not-found`, `wrong-password`, etc.)
- [ ] Testear flujo Google Sign-In en entorno real web (requiere `clientId` configurado)

### Datos / Módulos
- [ ] Conectar `CompanyScreen` con Firestore: guardar y leer datos de empresa del usuario autenticado
- [ ] Conectar `SalesScreen`, `PurchasesScreen`, `StockScreen` con colecciones Firestore
- [ ] Implementar consultas reales en `StatsScreen` (actualmente placeholder)
- [ ] Implementar `ProfileScreen` con lectura/escritura del perfil de usuario en Firestore

### Navegación
- [ ] Resolver rutas duplicadas: `routes.dart` define `authService` y `app_routes.dart` define `AppRoutes`; unificar
- [ ] Revisar archivo `lib/app/utils/funtions.dart` (nombre con typo y sin uso aparente)

---

## 🟡 Media prioridad

### UX / UI
- [ ] Agregar estado de carga global (skeleton screens o shimmer) mientras se consulta Firestore
- [ ] Manejar estado vacío en módulos (primer uso sin datos)
- [ ] Implementar tema oscuro (`AppTheme.dark`) y selector de tema en `ProfileScreen`
- [ ] Agregar soporte de idioma en `ProfileScreen` para cambiar entre ES/EN en tiempo real
- [ ] Añadir feedback háptico / toast de éxito al guardar en formularios

### Registro
- [ ] Agregar campos de fecha real con `DatePicker` en ventas, compras y stock
- [ ] Validar montos numéricos en los formularios de registro
- [ ] Paginación o lazy loading en listas de registros

### Stats
- [ ] Integrar paquete de gráficos (`fl_chart` o `syncfusion_flutter_charts`) para visualizaciones
- [ ] Calcular totales mensuales de ventas y compras desde Firestore

---

## 🟢 Mejoras / Backlog

### Técnico
- [ ] Migrar localización a `flutter_gen` ARB una vez que el tooling sea estable en el entorno
- [ ] Configurar GitHub Actions: lint + build web en PR
- [ ] Separar `routes.dart` en un único archivo canónico (hay dos definiciones de `authService`)
- [ ] Agregar cobertura de tests al CI (objetivo: ≥ 60% de líneas en `lib/`)
- [ ] Publicar build web en GitHub Pages o Firebase Hosting

### Docs
- [ ] Diagrama de flujo de autenticación (Mermaid en `docs/auth.md`)
- [ ] Documentar schema completo de Firestore
- [ ] README con instrucciones de deploy en Firebase Hosting

### Tests
- [ ] Tests de integración para flujo login → dashboard
- [ ] Tests unitarios para `BackendConfig` (flags de configuración)
- [ ] Tests de widget para `LoginPage` con mocks de `AuthService`
- [ ] Tests de widget para `HomePage`

---

## ✅ Completado

- [x] Modernización de tema con Material 3
- [x] Internacionalización ES/EN con `AppLocalizations` custom
- [x] Configuración de Firebase (core, auth, firestore) como dependencias
- [x] Configuración de Supabase Flutter
- [x] Google Sign-In (botón nativo web + flujo móvil)
- [x] `AuthService` con singleton, `ChangeNotifier`, flujo Firebase + Supabase
- [x] `BackendBootstrap` para inicialización segura en `main()`
- [x] Router protegido con `GoRouter` + redirect por estado de auth
- [x] `MyDrawer` con usuario actual y botón de logout
- [x] Pantalla de login con toggle sign-in / sign-up y validación
- [x] `flutter analyze` — 0 issues
- [x] `flutter build web --no-tree-shake-icons` — exitoso
- [x] Push a `origin/main`
