
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'questionnaire_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color blush = Color(0xFFF5D5D2);
  static const Color peach = Color(0xFFF6C9B8);
  static const Color rose = Color(0xFFDDAAB4);
  static const Color lavender = Color(0xFFB8A0BC);
  static const Color mauve = Color(0xFF806B88);
  static const Color deepMauve = Color(0xFF514557);
  static const Color ink = Color(0xFF493D4B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Dreamy pastel mountain background.
          const _DreamyMountainBackground(),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        26, 24, 26, 28,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // App identity.
                          Row(
                            children: [
                              Container(
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(
                                    alpha: 0.48,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(
                                      alpha: 0.65,
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.favorite_rounded,
                                  color: deepMauve,
                                  size: 23,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'with me',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.7,
                                  color: ink,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 44),

                          // Welcome text.
                          const Text(
                            "Hi, I'm Yuki. 👋",
                            style: TextStyle(
                              fontSize: 35,
                              height: 1.15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1.1,
                              color: ink,
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            'Before We Begin…',
                            style: TextStyle(
                              fontSize: 24,
                              height: 1.25,
                              fontWeight: FontWeight.w600,
                              color: deepMauve,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "I'd love to get to know you.",
                            style: TextStyle(
                              fontSize: 17,
                              height: 1.5,
                              color: ink.withValues(alpha: 0.82),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Gentle decorative divider.
                          Row(
                            children: [
                              Container(
                                width: 42,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: mauve.withValues(alpha: 0.75),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Container(
                                width: 8,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: mauve.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),

                          // Keep the lower area open for Yuki's
                          // real character model in a future update.
                          const SizedBox(height: 250),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.42),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.65),
                              ),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.auto_awesome_rounded,
                                  color: deepMauve,
                                  size: 25,
                                ),
                                SizedBox(width: 13),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'A little about you',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: ink,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        'A few simple questions will help '
                                        'make our conversations feel more '
                                        'personal. Take your time.',
                                        style: TextStyle(
                                          fontSize: 14,
                                          height: 1.5,
                                          color: deepMauve,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 22),

                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const QuestionnaireScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: deepMauve,
                                foregroundColor: Colors.white,
                                elevation: 3,
                                shadowColor: deepMauve.withValues(
                                  alpha: 0.25,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Let's Begin",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 21,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          Center(
                            child: Text(
                              'One little step at a time ♡',
                              style: TextStyle(
                                fontSize: 13,
                                color: ink.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DreamyMountainBackground extends StatelessWidget {
  const _DreamyMountainBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Warm peach-pink sky.
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF9DCD1),
                Color(0xFFF0CFD3),
                Color(0xFFD9C1D5),
                Color(0xFFB8A4C1),
              ],
              stops: [0.0, 0.34, 0.70, 1.0],
            ),
          ),
        ),

        // Soft glow in the sky.
        Positioned(
          top: 105,
          right: -75,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.38),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        // Distant mountain silhouettes.
        const Positioned.fill(
          child: CustomPaint(
            painter: _MountainPainter(
              color: Color(0xFFD7B9CE),
              heightFactor: 0.59,
              phase: 0.5,
              seed: 2,
            ),
          ),
        ),

        const Positioned.fill(
          child: CustomPaint(
            painter: _MountainPainter(
              color: Color(0xFFB79CB9),
              heightFactor: 0.70,
              phase: 2.0,
              seed: 5,
            ),
          ),
        ),

        const Positioned.fill(
          child: CustomPaint(
            painter: _MountainPainter(
              color: Color(0xFF96809F),
              heightFactor: 0.81,
              phase: 4.0,
              seed: 8,
            ),
          ),
        ),

        // Foreground ledge: intentionally empty for Yuki later.
        const Positioned.fill(
          child: CustomPaint(
            painter: _MountainPainter(
              color: Color(0xFF66566F),
              heightFactor: 0.91,
              phase: 1.2,
              seed: 11,
            ),
          ),
        ),

        // A subtle atmospheric wash blends the landscape.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.04),
                Colors.transparent,
                const Color(0xFF55465E).withValues(alpha: 0.08),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MountainPainter extends CustomPainter {
  final Color color;
  final double heightFactor;
  final double phase;
  final int seed;

  const _MountainPainter({
    required this.color,
    required this.heightFactor,
    required this.phase,
    required this.seed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * heightFactor);

    // Smooth, uneven peaks for a layered mountain silhouette.
    const steps = 8;
    for (int i = 0; i <= steps; i++) {
      final x = size.width * i / steps;
      final wave = math.sin(i * 1.45 + phase) * 0.045;
      final smallerWave = math.cos(i * 2.2 + seed) * 0.018;
      final y = size.height *
          (heightFactor - wave - smallerWave);

      path.lineTo(x, y);
    }

    path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant _MountainPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.heightFactor != heightFactor ||
        oldDelegate.phase != phase ||
        oldDelegate.seed != seed;
  }
}
