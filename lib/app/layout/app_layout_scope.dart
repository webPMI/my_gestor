import 'package:flutter/material.dart';

enum ScreenType { mobile, tablet, desktop }

class AppLayoutState {
  const AppLayoutState._({required this.size, required this.type});

  final Size size;
  final ScreenType type;

  static AppLayoutState fromSize(Size size) {
    final width = size.width;
    if (width < 720) {
      return AppLayoutState._(size: size, type: ScreenType.mobile);
    }
    if (width < 1100) {
      return AppLayoutState._(size: size, type: ScreenType.tablet);
    }
    return AppLayoutState._(size: size, type: ScreenType.desktop);
  }

  bool get isMobile => type == ScreenType.mobile;
  bool get isTablet => type == ScreenType.tablet;
  bool get isDesktop => type == ScreenType.desktop;

  EdgeInsets get pagePadding {
    switch (type) {
      case ScreenType.mobile:
        return const EdgeInsets.fromLTRB(8, 8, 8, 12);
      case ScreenType.tablet:
        return const EdgeInsets.fromLTRB(16, 16, 16, 20);
      case ScreenType.desktop:
        return const EdgeInsets.fromLTRB(24, 24, 24, 28);
    }
  }

  EdgeInsets get formOuterPadding {
    switch (type) {
      case ScreenType.mobile:
        return const EdgeInsets.all(8);
      case ScreenType.tablet:
        return const EdgeInsets.all(16);
      case ScreenType.desktop:
        return const EdgeInsets.all(20);
    }
  }

  double get cardPadding {
    switch (type) {
      case ScreenType.mobile:
        return 16;
      case ScreenType.tablet:
        return 20;
      case ScreenType.desktop:
        return 24;
    }
  }

  double get homeMaxWidth => isDesktop ? 1280 : 1120;

  double get loginMaxWidth {
    if (isMobile) {
      return size.width;
    }
    return isDesktop ? 640 : 560;
  }

  double get sectionGap {
    switch (type) {
      case ScreenType.mobile:
        return 12;
      case ScreenType.tablet:
        return 16;
      case ScreenType.desktop:
        return 24;
    }
  }
}

class AppLayoutScope extends InheritedWidget {
  const AppLayoutScope({super.key, required this.state, required super.child});

  final AppLayoutState state;

  static AppLayoutState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppLayoutScope>();
    if (scope != null) {
      return scope.state;
    }

    // Fallback útil para tests o subárboles que no pasan por MyApp.builder.
    return AppLayoutState.fromSize(MediaQuery.sizeOf(context));
  }

  @override
  bool updateShouldNotify(AppLayoutScope oldWidget) {
    return oldWidget.state.size != state.size ||
        oldWidget.state.type != state.type;
  }
}

class AppLayoutProvider extends StatelessWidget {
  const AppLayoutProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final state = AppLayoutState.fromSize(size);
    return AppLayoutScope(state: state, child: child);
  }
}
