import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_service.dart';
import '../localization/app_localizations.dart';
import '../utils/app_routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.path;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final currentUser = authService.currentUser;

    final options = [
      _DrawerOption(l10n.navCompany, Icons.business, AppRoutes.company),
      _DrawerOption(
        l10n.navRegisters,
        Icons.app_registration_rounded,
        AppRoutes.register,
      ),
      _DrawerOption(
        l10n.navGraphics,
        Icons.stacked_bar_chart_outlined,
        AppRoutes.stats,
      ),
      _DrawerOption(l10n.navProfile, Icons.person, AppRoutes.profile),
      _DrawerOption(l10n.navTools, Icons.toggle_on_sharp, AppRoutes.tools),
    ];

    return Drawer(
      width: 280,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.grid_view_rounded,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.navTitle, style: textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      l10n.navSubtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (currentUser != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        currentUser.email ?? currentUser.displayName ?? '',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: options.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      final isSelected = currentRoute == option.route;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorScheme.secondaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          selected: isSelected,
                          selectedColor: colorScheme.onSecondaryContainer,
                          leading: Icon(
                            option.icon,
                            color: isSelected
                                ? colorScheme.onSecondaryContainer
                                : colorScheme.onSurfaceVariant,
                          ),
                          title: Text(option.label),
                          trailing: isSelected
                              ? Icon(
                                  Icons.chevron_right_rounded,
                                  color: colorScheme.onSecondaryContainer,
                                )
                              : null,
                          onTap: () {
                            context.go(option.route);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: () async {
                  await authService.signOut();
                },
                icon: const Icon(Icons.logout_rounded),
                label: Text(l10n.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerOption {
  const _DrawerOption(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}
