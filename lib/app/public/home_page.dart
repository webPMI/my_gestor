import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../localization/app_localizations.dart';
import '../utils/app_routes.dart';
import '../utils/app_metadata.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(AppMetadata.appName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.tonalIcon(
              onPressed: () {
                context.go(AppRoutes.login);
              },
              icon: const Icon(Icons.login_rounded),
              label: Text(l10n.loginTitle),
            ),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer.withValues(alpha: 0.72),
              colorScheme.surface,
              const Color(0xFFE6FFF9),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -30,
              child: _GlowOrb(
                size: 240,
                color: colorScheme.secondary.withValues(alpha: 0.18),
              ),
            ),
            Positioned(
              left: -50,
              bottom: 40,
              child: _GlowOrb(
                size: 180,
                color: colorScheme.primary.withValues(alpha: 0.10),
              ),
            ),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    child: SingleChildScrollView(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isCompact = constraints.maxWidth < 860;

                          return Flex(
                            direction: isCompact
                                ? Axis.vertical
                                : Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 12,
                                child: _Reveal(
                                  delay: 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.62,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                          border: Border.all(
                                            color: colorScheme.outlineVariant,
                                          ),
                                        ),
                                        child: Text(
                                          l10n.homeBadge,
                                          style: theme.textTheme.labelLarge,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        l10n.homeHeadline,
                                        style: theme.textTheme.displaySmall,
                                      ),
                                      const SizedBox(height: 18),
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 620,
                                        ),
                                        child: Text(
                                          l10n.homeBody,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                                height: 1.5,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(height: 28),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        children: [
                                          _FeatureChip(
                                            label: l10n.homeFeatureCompanies,
                                          ),
                                          _FeatureChip(
                                            label: l10n.homeFeatureRecords,
                                          ),
                                          _FeatureChip(
                                            label: l10n.homeFeatureReports,
                                          ),
                                          _FeatureChip(
                                            label: l10n.homeFeatureTools,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 32),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          FilledButton.icon(
                                            onPressed: () {
                                              context.go(AppRoutes.login);
                                            },
                                            icon: const Icon(
                                              Icons.rocket_launch_rounded,
                                            ),
                                            label: Text(
                                              l10n.homeCtaOpenPlatform,
                                            ),
                                          ),
                                          OutlinedButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.insights_rounded,
                                            ),
                                            label: Text(
                                              l10n.homeCtaViewExperience,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        '${AppMetadata.companyName} · ${AppMetadata.ownerName}',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color:
                                                  colorScheme.onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: isCompact ? 0 : 28,
                                height: isCompact ? 28 : 0,
                              ),
                              Expanded(
                                flex: 10,
                                child: _Reveal(
                                  delay: 120,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Padding(
                                      padding: const EdgeInsets.all(28),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.auto_graph_rounded,
                                                color: colorScheme.primary,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                l10n.homePanelTitle,
                                                style:
                                                    theme.textTheme.titleLarge,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 24),
                                          _MetricTile(
                                            title:
                                                l10n.homeMetricMonthlyFlowTitle,
                                            value: '+18.4%',
                                            caption: l10n
                                                .homeMetricMonthlyFlowCaption,
                                          ),
                                          const SizedBox(height: 14),
                                          _MetricTile(
                                            title:
                                                l10n.homeMetricOperationsTitle,
                                            value: '1,284',
                                            caption: l10n
                                                .homeMetricOperationsCaption,
                                          ),
                                          const SizedBox(height: 14),
                                          _MetricTile(
                                            title: l10n.homeMetricAlertsTitle,
                                            value: '96%',
                                            caption:
                                                l10n.homeMetricAlertsCaption,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 420),
      tween: Tween(begin: 0.92, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Chip(
        avatar: const Icon(Icons.check_circle_outline_rounded, size: 18),
        label: Text(label),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.title,
    required this.value,
    required this.caption,
  });

  final String title;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.trending_up_rounded, color: colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  caption,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(value, style: theme.textTheme.headlineSmall),
        ],
      ),
    );
  }
}

class _Reveal extends StatelessWidget {
  const _Reveal({required this.child, required this.delay});

  final Widget child;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 560 + delay),
      tween: Tween(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, animatedChild) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 28 * (1 - value)),
            child: animatedChild,
          ),
        );
      },
      child: child,
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}
