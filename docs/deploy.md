# Guía de Deploy

## Build web

```bash
flutter build web --no-tree-shake-icons \
  --dart-define=FIREBASE_API_KEY=... \
  --dart-define=FIREBASE_APP_ID=... \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=... \
  --dart-define=FIREBASE_PROJECT_ID=... \
  --dart-define=FIREBASE_AUTH_DOMAIN=... \
  --dart-define=GOOGLE_CLIENT_ID=... \
  --dart-define=SUPABASE_URL=... \
  --dart-define=SUPABASE_ANON_KEY=...
```

El artefacto queda en `build/web/`.

---

## Firebase Hosting (recomendado)

```bash
# Instalar CLI de Firebase (una vez)
npm install -g firebase-tools

# Login y deploy
firebase login
firebase init hosting   # apuntar public dir a: build/web
firebase deploy
```

---

## GitHub Pages (alternativa)

1. Subir el contenido de `build/web/` a la rama `gh-pages`.
2. Habilitar Pages en Settings → Pages → Branch: `gh-pages` / `/root`.
3. Si el repo no está en la raíz del dominio, cambiar `--base-href` en el comando de build:

```bash
flutter build web --no-tree-shake-icons --base-href /my_gestor/
```

---

## Configuración Firebase (consola)

1. Authentication → Sign-in method: habilitar **Email/Password** y **Google**.
2. Firestore → Crear base de datos en la región más cercana.
3. Agregar la URL del hosting a los **Authorized domains** en Authentication.
4. En Google Sign-In: agregar el dominio a los **Authorized JavaScript origins** del OAuth Client.

---

## index.html — meta tag Google Sign-In (web)

Agregar dentro de `<head>` en `web/index.html`:

```html
<meta name="google-signin-client_id" content="TU_GOOGLE_CLIENT_ID">
```

Esto permite que `google_sign_in_web` detecte el `clientId` automáticamente sin necesidad de pasarlo por env var en el HTML.

---

## Análisis y tests (CI mínimo)

```bash
flutter analyze
flutter test
flutter build web --no-tree-shake-icons
```
