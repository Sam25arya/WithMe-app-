import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'questionnaire_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 28,
          ),
          child: Column(
            children: [
              // =============================================================
              // WITH ME LOGO
              // =============================================================

              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Image.asset(
                      'assets/images/withme_logo.jpeg',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.primary,
                          size: 52,
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =============================================================
              // APP NAME
              // =============================================================

              const Text(
                'With Me',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 10),

              // =============================================================
              // TAG
              // =============================================================

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.30),
                  ),
                ),
                child: const Text(
                  'YOUR AI COMPANION',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // =============================================================
              // GET STARTED ICON
              // =============================================================

              Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.55),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 32,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.electricViolet,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    color: AppColors.background,
                    size: 52,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =============================================================
              // TITLE
              // =============================================================

              const Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Let’s get to know you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 18),

              // =============================================================
              // DESCRIPTION
              // =============================================================

              const Text(
                "A few simple questions will help your companion "
                "understand you better and make every conversation "
                "feel more personal.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // =============================================================
              // FEATURE CARD 1
              // =============================================================

              _FeatureCard(
                icon: Icons.psychology_outlined,
                title: 'Understand You',
                subtitle:
                    'Learn your personality, interests, preferences and more.',
              ),

              const SizedBox(height: 14),

              // =============================================================
              // FEATURE CARD 2
              // =============================================================

              _FeatureCard(
                icon: Icons.favorite_border_rounded,
                title: 'Personalize Your Companion',
                subtitle:
                    'Choose how your AI companion should talk and interact with you.',
              ),

              const SizedBox(height: 14),

              // =============================================================
              // FEATURE CARD 3
              // =============================================================

              _FeatureCard(
                icon: Icons.lock_outline_rounded,
                title: 'Your Preferences',
                subtitle:
                    'You decide what your companion should remember about you.',
              ),

              const SizedBox(height: 32),

              // =============================================================
              // GET STARTED BUTTON
              // =============================================================

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const QuestionnaireScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background,
                    elevation: 5,
                    shadowColor:
                        AppColors.primary.withValues(alpha: 0.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Let’s Begin',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =============================================================
              // FOOTER
              // =============================================================

              const Text(
                'You can always change your preferences later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// FEATURE CARD
// ============================================================================

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.indigoSlate,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // ---------------------------------------------------------------
          // ICON
          // ---------------------------------------------------------------

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.22),
              ),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryLight,
              size: 25,
            ),
          ),

          const SizedBox(width: 17),

          // ---------------------------------------------------------------
          // TEXT
          // ---------------------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}