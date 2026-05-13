import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/backend_config.dart';

class BackendBootstrap {
  const BackendBootstrap._();

  static Future<void> initialize() async {
    final firebaseOptions = BackendConfig.firebaseOptions;
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
}
