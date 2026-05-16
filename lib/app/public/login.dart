import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_service.dart';
import '../layout/app_layout_scope.dart';
import '../components/google_auth_button.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../localization/app_localizations.dart';
import '../utils/app_routes.dart';

enum _AuthMode { signIn, signUp }

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _rememberMe = true;
  bool _loading = false;
  _AuthMode _mode = _AuthMode.signIn;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _loading = true;
    });

    try {
      if (_mode == _AuthMode.signIn) {
        await authService.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await authService.signUpWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on BackendNotConfiguredException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? l10n.loginAuthError)),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.loginAuthError)));
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    final l10n = AppLocalizations.of(context);

    setState(() {
      _loading = true;
    });

    try {
      await authService.signInWithGoogle();
    } on AuthCancelledException {
      // User cancelled the Google sign-in flow.
    } on BackendNotConfiguredException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.loginAuthError)));
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final layout = AppLayoutScope.of(context);
    final isSignIn = _mode == _AuthMode.signIn;
    final firebaseReady = authService.firebaseEnabled;
    final supabaseReady = authService.supabaseEnabled;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primaryContainer.withValues(alpha: 0.70),
              colorScheme.surface,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: layout.formOuterPadding,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 520),
                  tween: Tween(begin: 0, end: 1),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 24 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: layout.loginMaxWidth),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(layout.cardPadding),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.10,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(
                                  Icons.lock_person_rounded,
                                  color: colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                isSignIn
                                    ? l10n.loginModeSignIn
                                    : l10n.loginModeSignUp,
                                style: theme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                l10n.loginDescription,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SegmentedButton<_AuthMode>(
                                segments: [
                                  ButtonSegment(
                                    value: _AuthMode.signIn,
                                    label: Text(l10n.loginModeSignIn),
                                    icon: const Icon(Icons.login_rounded),
                                  ),
                                  ButtonSegment(
                                    value: _AuthMode.signUp,
                                    label: Text(l10n.loginModeSignUp),
                                    icon: const Icon(
                                      Icons.person_add_alt_1_rounded,
                                    ),
                                  ),
                                ],
                                selected: {_mode},
                                onSelectionChanged: (selected) {
                                  setState(() {
                                    _mode = selected.first;
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                              MyTextField(
                                width: double.infinity,
                                controller: _emailController,
                                hintText: l10n.loginEmailHint,
                                labelText: l10n.loginEmailLabel,
                                icon: Icons.alternate_email_rounded,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return l10n.loginEmailRequired;
                                  }
                                  if (!value.contains('@')) {
                                    return l10n.loginEmailRequired;
                                  }
                                  return null;
                                },
                              ),
                              MyTextField(
                                width: double.infinity,
                                controller: _passwordController,
                                hintText: l10n.loginPasswordHint,
                                labelText: l10n.loginPasswordLabel,
                                obscureText: true,
                                icon: Icons.password_rounded,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return l10n.loginPasswordRequired;
                                  }
                                  return null;
                                },
                              ),
                              if (!isSignIn)
                                MyTextField(
                                  width: double.infinity,
                                  controller: _confirmPasswordController,
                                  hintText: l10n.loginConfirmPasswordHint,
                                  labelText: l10n.loginConfirmPasswordLabel,
                                  obscureText: true,
                                  icon: Icons.password_rounded,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return l10n.loginConfirmPasswordRequired;
                                    }
                                    if (value != _passwordController.text) {
                                      return l10n.loginConfirmPasswordRequired;
                                    }
                                    return null;
                                  },
                                ),
                              const SizedBox(height: 4),
                              if (isSignIn)
                                SwitchListTile.adaptive(
                                  contentPadding: EdgeInsets.zero,
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value;
                                    });
                                  },
                                  title: Text(l10n.loginRememberMe),
                                ),
                              if (isSignIn)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(l10n.loginForgotPassword),
                                  ),
                                ),
                              const SizedBox(height: 8),
                              if (!firebaseReady)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    l10n.loginBackendMissing,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.error,
                                    ),
                                  ),
                                ),
                              if (firebaseReady && !supabaseReady)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    l10n.loginSupabaseOptional,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              MyButton(
                                text: isSignIn
                                    ? l10n.loginModeSignIn
                                    : l10n.loginModeSignUp,
                                icon: isSignIn
                                    ? Icons.arrow_forward_rounded
                                    : Icons.person_add_alt_1_rounded,
                                onPressed: _loading ? null : _submit,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: colorScheme.outlineVariant,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(l10n.loginOrContinue),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: colorScheme.outlineVariant,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              GoogleAuthButton(
                                label: l10n.loginGoogle,
                                loading: _loading,
                                onPressed: _signInWithGoogle,
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () {
                                  context.go(AppRoutes.home);
                                },
                                child: Text(l10n.loginBackHome),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
