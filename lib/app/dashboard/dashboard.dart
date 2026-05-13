import 'package:flutter/material.dart';
import 'package:my_gestor/app/components/my_drawer.dart';

import '../utils/app_metadata.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(AppMetadata.appName),
        ),
        drawer: const MyDrawer(),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: KeyedSubtree(
            key: ValueKey(child.runtimeType),
            child: child,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.18),
              ],
            ),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                child: MyDrawer(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 320),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: KeyedSubtree(
                      key: ValueKey(child.runtimeType),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: child,
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
}