// Stub para plataformas no web.
// En tests (VM) y plataformas nativas este archivo es importado en lugar de
// google_sign_in_web/web_only.dart, evitando dependencias de dart:ui_web.

import 'package:flutter/material.dart';

Widget renderButton({dynamic configuration}) => const SizedBox.shrink();
