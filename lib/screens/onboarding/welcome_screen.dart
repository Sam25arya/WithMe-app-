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
              // --------------------------------------------------
              // LOGO
              // --------------------------------------------------
              Image.asset(
                'assets/images/withme_logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 24),

              // --------------------------------------------------
              // APP NAME
              // --------------------------------------------------
              const Text(
                'With Me',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // --------------------------------------------------
              // TAG
              // --------------------------------------------------
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentRed.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.accentRed.withValues(alpha: 0.4),
                  ),
                ),
                child: const Text(
                  'YOUR AI COMPANION',
                  style: TextStyle(
                    color: AppColors.highlightGold,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 45),

              // --------------------------------------------------
              // ROCKET ICON
              // --------------------------------------------------
              Container(
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accentRed,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentRed.withValues(alpha: 0.35),
                      blurRadius: 35,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentRed,
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    color: Colors.white,
                    size: 58,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // --------------------------------------------------
              // GET STARTED TITLE
              // --------------------------------------------------
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
                'To know you better',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.accentRed,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "Help us tailor your companion's voice, empathy, "
                'and conversation style so every interaction '
                'feels deeply personal.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // --------------------------------------------------
              // FEATURE CARD 1
              // --------------------------------------------------
              _FeatureCard(
                icon: Icons.psychology_outlined,
                title: 'Personality Calibration',
                subtitle:
                    'Adaptive responses tuned to your energy and mood',
              ),

              const SizedBox(height: 14),

              // --------------------------------------------------
              // FEATURE CARD 2
              // --------------------------------------------------
              _FeatureCard(
                icon: Icons.mic_none_rounded,
                title: 'Voice & Tone Preferences',
                subtitle:
                    'Choose how your companion speaks and listens to you',
              ),

              const SizedBox(height: 14),

              // --------------------------------------------------
              // FEATURE CARD 3
              // --------------------------------------------------
              _FeatureCard(
                icon: Icons.lock_outline_rounded,
                title: '100% Private & Encrypted',
                subtitle:
                    'Your conversations and answers remain solely yours',
              ),

              const SizedBox(height: 32),

              // --------------------------------------------------
              // GET STARTED BUTTON
              // --------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const QuestionnaireScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 24,
                  ),
                  label: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentRed,
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shadowColor:
                        AppColors.accentRed.withValues(alpha: 0.35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'You can always change your preferences later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
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

// ================================================================
// FEATURE CARD
// ================================================================

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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111A2D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF263451),
        ),
      ),
      child: Row(
        children: [
          // Icon box
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.accentRed.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.accentRed.withValues(alpha: 0.25),
              ),
            ),
            child: Icon(
              icon,
              color: AppColors.accentRed,
              size: 25,
            ),
          ),

          const SizedBox(width: 18),

          // Text
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