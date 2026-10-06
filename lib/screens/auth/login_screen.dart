import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../../services/auth/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

/// LoginScreen — users sign in to their With Me account.
/// Fully connected to AuthService / Firebase Auth.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // EMAIL / PASSWORD LOGIN
  // ===========================================================================

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      // Firebase authentication is successful.
      // Navigate to onboarding/dashboard according to the current app flow.
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );
    } catch (errorMsg) {
      if (!mounted) return;

      _showError(errorMsg.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ===========================================================================
  // GOOGLE LOGIN
  // ===========================================================================

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithGoogle();

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );
    } catch (errorMsg) {
      if (!mounted) return;

      _showError(errorMsg.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ===========================================================================
  // FORGOT PASSWORD
  // ===========================================================================

  void _handleForgotPassword() {
    final TextEditingController dialogEmailController =
        TextEditingController(
      text: _emailController.text.trim(),
    );

    bool sending = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF101929),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                '🔑 Reset Password',
                style: TextStyle(
                  color: Color(0xFFF5F1E8),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter your email and we\'ll send you a link to reset your password.',
                    style: TextStyle(
                      color: Color(0xFFB8BECC),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: dialogEmailController,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    enabled: !sending,
                    style: const TextStyle(
                      color: Color(0xFFF5F1E8),
                    ),
                    decoration: InputDecoration(
                      hintText: 'your@email.com',
                      hintStyle: const TextStyle(
                        color: Color(0xFF5A6070),
                      ),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Color(0xFFB8BECC),
                        size: 20,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0D1626),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF242D4A),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF242D4A),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFE52535),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: sending
                      ? null
                      : () {
                          Navigator.of(dialogContext).pop();
                        },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF5A6070),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: sending
                      ? null
                      : () async {
                          final String email =
                              dialogEmailController.text.trim();

                          if (email.isEmpty || !email.contains('@')) {
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xFF2A0A0E),
                                content: Text(
                                  'Please enter a valid email address.',
                                  style: TextStyle(
                                    color: Color(0xFFFF6B7A),
                                  ),
                                ),
                              ),
                            );
                            return;
                          }

                          setDialogState(() {
                            sending = true;
                          });

                          try {
                            await _authService.sendPasswordResetEmail(
                              email: email,
                            );

                            if (!dialogContext.mounted) return;

                            Navigator.of(dialogContext).pop();

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: const Color(0xFF0D1F14),
                                content: Text(
                                  '📧 Reset link sent to $email — check your inbox!',
                                  style: const TextStyle(
                                    color: Color(0xFF6FCF97),
                                  ),
                                ),
                                duration: const Duration(seconds: 4),
                              ),
                            );
                          } catch (error) {
                            if (!dialogContext.mounted) return;

                            setDialogState(() {
                              sending = false;
                            });

                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                backgroundColor: const Color(0xFF2A0A0E),
                                content: Text(
                                  error.toString(),
                                  style: const TextStyle(
                                    color: Color(0xFFFF6B7A),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                  child: sending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFFE52535),
                          ),
                        )
                      : const Text(
                          'Send Reset Link',
                          style: TextStyle(
                            color: Color(0xFFE52535),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      dialogEmailController.dispose();
    });
  }

  // ===========================================================================
  // ERROR MESSAGE
  // ===========================================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2A0A0E),
        content: Text(
          message,
          style: const TextStyle(
            color: Color(0xFFFF6B7A),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B16),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // =============================================================
                  // LOGO
                  // =============================================================

                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentRed.withValues(
                            alpha: 0.40,
                          ),
                          blurRadius: 35,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset(
                        'assets/images/withme_logo.jpeg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.surfaceLight,
                            child: const Icon(
                              Icons.auto_awesome,
                              size: 40,
                              color: AppColors.accentRed,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =============================================================
                  // WELCOME TITLE
                  // =============================================================

                  const Text(
                    AppStrings.welcomeTitle,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // =============================================================
                  // SUBTITLE
                  // =============================================================

                  const Text(
                    'Sign in to connect with your AI companion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 36),

                  // =============================================================
                  // EMAIL
                  // =============================================================

                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    labelText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // =============================================================
                  // PASSWORD
                  // =============================================================

                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // =============================================================
                  // REMEMBER ME + FORGOT PASSWORD
                  // =============================================================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: AppColors.accentRed,
                            checkColor: Colors.white,
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: _handleForgotPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.highlightGold,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // =============================================================
                  // SIGN IN
                  // =============================================================

                  CustomButton(
                    text: 'Sign In',
                    isLoading: _isLoading,
                    onPressed: _handleLogin,
                  ),

                  const SizedBox(height: 20),

                  // =============================================================
                  // OR DIVIDER
                  // =============================================================

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.textSecondary.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.textSecondary.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // =============================================================
                  // GOOGLE SIGN IN
                  // =============================================================

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed:
                          _isLoading ? null : _handleGoogleSignIn,
                      icon: const Icon(
                        Icons.g_mobiledata,
                        size: 30,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.textSecondary.withValues(
                            alpha: 0.35,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // =============================================================
                  // SIGN UP
                  // =============================================================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.register,
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColors.accentRed,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}