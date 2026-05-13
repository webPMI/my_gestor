import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gestor/app/dashboard/profile/profile_screen.dart';
import 'package:my_gestor/app/dashboard/tools/tools_screen.dart';

import '../auth/auth_service.dart';
import 'app_routes.dart';
import '../dashboard/company/company_screen.dart';
import '../dashboard/dashboard.dart';
import '../dashboard/register/register_screen.dart';
import '../dashboard/stats/stats_screen.dart';
import '../public/home_page.dart';
import '../public/login.dart';

final AuthService authService = AuthService.instance;

final GoRouter router = GoRouter(
  refreshListenable: authService,
  initialLocation: AppRoutes.home,
  redirect: (context, state) {
    final path = state.uri.path;
    final isSignedIn = authService.isSignedIn;

    if (!isSignedIn && _requiresAuth(path)) {
      return AppRoutes.login;
    }

    if (isSignedIn && (path == AppRoutes.home || path == AppRoutes.login)) {
      return AppRoutes.company;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) =>
          _buildPage(context: context, state: state, child: const HomePage()),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) =>
          _buildPage(context: context, state: state, child: const Login()),
    ),
    ShellRoute(
      builder: (context, state, child) => Dashboard(child: child),
      routes: userRoutes,
    ),
  ],
);

bool _requiresAuth(String path) {
  return path == AppRoutes.company ||
      path == AppRoutes.register ||
      path == AppRoutes.stats ||
      path == AppRoutes.profile ||
      path == AppRoutes.tools;
}

final userRoutes = [
  GoRoute(
    path: AppRoutes.tools,
    pageBuilder: (context, state) =>
        _buildPage(context: context, state: state, child: const ToolsScreen()),
  ),
  GoRoute(
    path: AppRoutes.company,
    pageBuilder: (context, state) => _buildPage(
      context: context,
      state: state,
      child: const CompanyScreen(),
    ),
  ),
  GoRoute(
    path: AppRoutes.register,
    pageBuilder: (context, state) => _buildPage(
      context: context,
      state: state,
      child: const RegisterScreen(),
    ),
  ),
  GoRoute(
    path: AppRoutes.stats,
    pageBuilder: (context, state) =>
        _buildPage(context: context, state: state, child: const StatsScreen()),
  ),
  GoRoute(
    path: AppRoutes.profile,
    pageBuilder: (context, state) => _buildPage(
      context: context,
      state: state,
      child: const ProfileScreen(),
    ),
  ),
];

CustomTransitionPage<void> _buildPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 420),
    reverseTransitionDuration: const Duration(milliseconds: 320),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fade = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      final slide = Tween<Offset>(
        begin: const Offset(0.02, 0.02),
        end: Offset.zero,
      ).animate(fade);
      final scale = Tween<double>(begin: 0.985, end: 1).animate(fade);

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: ScaleTransition(scale: scale, child: child),
        ),
      );
    },
  );
}
