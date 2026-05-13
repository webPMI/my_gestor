# Schema de Base de Datos

## Firestore — colección `users`

Creado/actualizado en cada login por `AuthService._syncFirestoreUser()`.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `uid` | `String` | UID de Firebase Auth (también es el ID del documento) |
| `email` | `String?` | Correo del usuario |
| `displayName` | `String?` | Nombre visible |
| `photoURL` | `String?` | URL de avatar |
| `provider` | `String` | `"password"` o `"google"` |
| `lastLoginAt` | `Timestamp` | Fecha del último login (serverTimestamp) |

**Path:** `users/{uid}`

---

## Firestore — colección `companies` (pendiente)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `ownerId` | `String` | UID del usuario propietario |
| `name` | `String` | Nombre de la empresa |
| `createdAt` | `Timestamp` | Fecha de creación |

**Path:** `companies/{companyId}`

---

## Firestore — colección `records` (pendiente)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `companyId` | `String` | Referencia a la empresa |
| `ownerId` | `String` | UID del usuario |
| `type` | `String` | `"sale"`, `"purchase"` o `"stock"` |
| `reference` | `String` | Número o código de referencia |
| `amount` | `Number` | Monto del registro |
| `date` | `Timestamp` | Fecha del movimiento |
| `notes` | `String?` | Observaciones |
| `createdAt` | `Timestamp` | serverTimestamp |

**Path:** `records/{recordId}`

---

## Supabase — tabla `profiles`

Creada/actualizada en cada login por `AuthService._syncSupabaseProfile()`.

```sql
create table profiles (
  id          text primary key,          -- Firebase UID
  email       text,
  display_name text,
  avatar_url  text,
  provider    text,
  updated_at  timestamptz default now()
);

-- Row Level Security
alter table profiles enable row level security;

create policy "Usuario puede ver su propio perfil"
  on profiles for select
  using (id = auth.uid()::text);

create policy "Usuario puede actualizar su propio perfil"
  on profiles for update
  using (id = auth.uid()::text);

create policy "Insertar perfil propio"
  on profiles for insert
  with check (id = auth.uid()::text);
```

> **Nota:** la columna `id` usa el UID de Firebase, no el UUID de Supabase Auth, porque la sesión de Supabase no se inicia directamente desde la app (solo se usa como backend secundario para perfiles).
