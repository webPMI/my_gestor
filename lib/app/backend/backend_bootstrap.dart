import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../firebase_options.dart';
import '../config/backend_config.dart';

class BackendBootstrap {
  const BackendBootstrap._();

  static Future<void> initialize() async {
    FirebaseOptions? firebaseOptions = BackendConfig.firebaseOptions;

    // Prefer explicit --dart-define values, fallback to FlutterFire config.
    firebaseOptions ??= _firebaseOptionsFromFlutterFire();

    if (firebaseOptions != null && Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: firebaseOptions);
    }

    if (BackendConfig.hasSupabase && !Supabase.instance.isInitialized) {
      await Supabase.initialize(
        url: BackendConfig.supabaseUrl,
        anonKey: BackendConfig.supabaseAnonKey,
      );
    }
  }

  static FirebaseOptions? _firebaseOptionsFromFlutterFire() {
    try {
      return DefaultFirebaseOptions.currentPlatform;
    } on UnsupportedError {
      return null;
    }
  }
}
