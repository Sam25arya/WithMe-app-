import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';

/// SplashScreen combines:
/// - Cinematic dark-light background
/// - Ambient red waves and corner circles
/// - With Me logo
/// - App title and tagline
/// - Firebase authentication check
///
/// Authentication flow:
/// - Existing Firebase user → Dashboard
/// - No Firebase user → Login
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _introController;
  AnimationController? _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _initAnimations();

    // Wait for the splash animation, then check authentication.
    _checkAuthentication();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // AUTHENTICATION CHECK
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _checkAuthentication() async {
    // Keep the splash screen visible for 2.8 seconds.
    await Future.delayed(const Duration(milliseconds: 2800));

    if (!mounted) return;

    // Firebase remembers the signed-in user.
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is already signed in.
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
      );
    } else {
      // No signed-in user.
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.login,
      );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // ANIMATIONS
  // ─────────────────────────────────────────────────────────────────────────

  void _initAnimations() {
    _introController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _introController!,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.90,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _introController!,
        curve: Curves.easeOutBack,
      ),
    );

    _pulseController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _pulseController!,
        curve: Curves.easeInOut,
      ),
    );

    if (!_introController!.isAnimating &&
        !_introController!.isCompleted) {
      _introController!.forward();
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    _initAnimations();
  }

  @override
  void dispose() {
    _introController?.dispose();
    _pulseController?.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF070B16),
      body: Stack(
        children: [
          // ───────────────────────────────────────────────────────────────
          // 1. CINEMATIC DARK-LIGHT BASE
          // ───────────────────────────────────────────────────────────────

          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF1A2640),
                  Color(0xFF131D32),
                  Color(0xFF090E1A),
                  Color(0xFF04060E),
                ],
                stops: [
                  0.0,
                  0.35,
                  0.70,
                  1.0,
                ],
              ),
            ),
          ),

          // ───────────────────────────────────────────────────────────────
          // 2. CENTER-RIGHT LUMINOUS POOL
          // ───────────────────────────────────────────────────────────────

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.10, -0.18),
                  radius: 0.95,
                  colors: [
                    const Color(0xFF1F2D4A).withValues(alpha: 0.70),
                    const Color(0xFF121A2D).withValues(alpha: 0.35),
                    Colors.transparent,
                  ],
                  stops: const [
                    0.0,
                    0.55,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          // ───────────────────────────────────────────────────────────────
          // 3. ATMOSPHERIC VIGNETTE
          // ───────────────────────────────────────────────────────────────

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.05, -0.15),
                  radius: 1.05,
                  colors: [
                    Colors.transparent,
                    Color(0x3503060C),
                    Color(0xB503060C),
                    Color(0xF203060C),
                  ],
                  stops: [
                    0.35,
                    0.65,
                    0.88,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          // ───────────────────────────────────────────────────────────────
          // 4. DIAGONAL DARK SHARD
          // ───────────────────────────────────────────────────────────────

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0, -1.0),
                  end: Alignment(1.0, 1.0),
                  colors: [
                    Color(0x661A2D52),
                    Color(0x33101E3A),
                    Colors.transparent,
                    Color(0x2210192E),
                    Color(0x551B2E50),
                  ],
                  stops: [
                    0.0,
                    0.22,
                    0.50,
                    0.78,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          // ───────────────────────────────────────────────────────────────
          // 5. SUBTLE BACKGROUND GLOW
          // ───────────────────────────────────────────────────────────────

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, 0.0),
                  radius: 0.80,
                  colors: [
                    Color(0x20182E4E),
                    Color(0x0E111F38),
                    Colors.transparent,
                  ],
                  stops: [
                    0.0,
                    0.55,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          // ───────────────────────────────────────────────────────────────
          // 6. TOP-LEFT RED GLOW
          // ───────────────────────────────────────────────────────────────

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.82, -0.82),
                  radius: 0.90,
                  colors: [
                    const Color(0xFFE52535).withValues(alpha: 0.18),
                    const Color(0xFF1A2848).withValues(alpha: 0.22),
                    Colors.transparent,
                  ],
                  stops: const [
                    0.0,
                    0.45,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          // ───────────────────────────────────────────────────────────────
          // 7. BOTTOM-RIGHT RED GLOW
          // ───────────────────────────────────────────────────────────────

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.82, 0.82),
                  radius: 0.90,
                  colors: [
                    const Color(0xFFE52535).withValues(alpha: 0.20),
                    const Color(0xFF18263F).withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                  stops: const [
                    0.0,
                    0.45,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          // ───────────────────────────────────────────────────────────────
          // 8. AMBIENT ATMOSPHERE
          // ───────────────────────────────────────────────────────────────

          Positioned.fill(
            child: CustomPaint(
              size: Size(size.width, size.height),
              painter: const _AmbientAtmospherePainter(),
            ),
          ),

          // ───────────────────────────────────────────────────────────────
          // 9. CENTRAL BRAND CONTENT
          // ───────────────────────────────────────────────────────────────

          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // LOGO
                    AnimatedBuilder(
                      animation: _pulseController!,
                      builder: (context, child) {
                        final glow = _glowAnimation.value;

                        return Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE52535)
                                    .withValues(alpha: 0.55 * glow),
                                blurRadius: 48 * glow,
                                spreadRadius: 2 * glow,
                                offset: Offset(
                                  0,
                                  -18 * glow,
                                ),
                              ),
                              BoxShadow(
                                color: const Color(0xFFE52535)
                                    .withValues(alpha: 0.45 * glow),
                                blurRadius: 42 * glow,
                                spreadRadius: 2 * glow,
                                offset: Offset(
                                  -16 * glow,
                                  0,
                                ),
                              ),
                              BoxShadow(
                                color: const Color(0xFFE52535)
                                    .withValues(alpha: 0.45 * glow),
                                blurRadius: 42 * glow,
                                spreadRadius: 2 * glow,
                                offset: Offset(
                                  16 * glow,
                                  0,
                                ),
                              ),
                              BoxShadow(
                                color: const Color(0xFFE52535)
                                    .withValues(alpha: 0.30 * glow),
                                blurRadius: 18 * glow,
                                spreadRadius: 1 * glow,
                                offset: Offset(
                                  0,
                                  -4 * glow,
                                ),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8E2D8),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  width: 1.0,
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/withme_logo.png',
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.surfaceLight,
                                    child: const Icon(
                                      Icons.auto_awesome,
                                      size: 72,
                                      color: AppColors.accentRed,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 36),

                    // APP TITLE
                    const Text(
                      AppStrings.appName,
                      style: TextStyle(
                        color: Color(0xFFF5F1E8),
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // TAGLINE
                    const Text(
                      AppStrings.appTagline,
                      style: TextStyle(
                        color: Color(0xFFD6B56D),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // DIVIDER
                    const _RedStarDivider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RED STAR DIVIDER
// ─────────────────────────────────────────────────────────────────────────────

class _RedStarDivider extends StatelessWidget {
  const _RedStarDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                const Color(0xFFE52535).withValues(alpha: 0.80),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomPaint(
            size: const Size(12, 12),
            painter: _DiamondStarPainter(
              color: const Color(0xFFE52535),
            ),
          ),
        ),

        Container(
          width: 50,
          height: 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFE52535).withValues(alpha: 0.80),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DIAMOND STAR PAINTER
// ─────────────────────────────────────────────────────────────────────────────

class _DiamondStarPainter extends CustomPainter {
  final Color color;

  _DiamondStarPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    final cx = size.width / 2;
    final cy = size.height / 2;

    path.moveTo(cx, 0);
    path.quadraticBezierTo(
      cx,
      cy,
      size.width,
      cy,
    );
    path.quadraticBezierTo(
      cx,
      cy,
      cx,
      size.height,
    );
    path.quadraticBezierTo(
      cx,
      cy,
      0,
      cy,
    );
    path.quadraticBezierTo(
      cx,
      cy,
      cx,
      0,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AMBIENT ATMOSPHERE PAINTER
// ─────────────────────────────────────────────────────────────────────────────

class _AmbientAtmospherePainter extends CustomPainter {
  const _AmbientAtmospherePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ─────────────────────────────────────────────────────────────────────
    // DARK WAVES
    // ─────────────────────────────────────────────────────────────────────

    final darkWavePaint = Paint()
      ..color = const Color(0xFF0D1626)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final darkWavePaint2 = Paint()
      ..color = const Color(0xFF111E33)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    // TOP WAVE
    final topWave = Path();

    topWave.moveTo(
      -30,
      h * 0.17,
    );

    topWave.cubicTo(
      w * 0.20,
      h * 0.11,
      w * 0.38,
      h * 0.11,
      w * 0.54,
      h * 0.17,
    );

    topWave.cubicTo(
      w * 0.70,
      h * 0.23,
      w * 0.86,
      h * 0.22,
      w + 40,
      h * 0.16,
    );

    canvas.drawPath(
      topWave,
      darkWavePaint,
    );

    // BOTTOM WAVE
    final bottomWave = Path();

    bottomWave.moveTo(
      -30,
      h * 0.81,
    );

    bottomWave.cubicTo(
      w * 0.18,
      h * 0.87,
      w * 0.36,
      h * 0.88,
      w * 0.52,
      h * 0.82,
    );

    bottomWave.cubicTo(
      w * 0.68,
      h * 0.74,
      w * 0.84,
      h * 0.73,
      w + 40,
      h * 0.79,
    );

    canvas.drawPath(
      bottomWave,
      darkWavePaint2,
    );

    // ─────────────────────────────────────────────────────────────────────
    // TOP-LEFT CIRCLE
    // ─────────────────────────────────────────────────────────────────────

    final tlCenter = const Offset(
      -30,
      -30,
    );

    const tlRadius = 300.0;

    final tlRect = Rect.fromCircle(
      center: tlCenter,
      radius: tlRadius,
    );

    final tlShader = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xFFFF253B),
        Color(0x99E52535),
        Color(0x33E52535),
        Colors.transparent,
      ],
      stops: [
        0.0,
        0.35,
        0.70,
        1.0,
      ],
    ).createShader(
      Rect.fromLTWH(
        0,
        0,
        tlRadius + 30,
        tlRadius + 30,
      ),
    );

    final tlGlowPaint = Paint()
      ..shader = tlShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        7.0,
      );

    final tlCorePaint = Paint()
      ..shader = tlShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.solid,
        1.5,
      );

    canvas.drawArc(
      tlRect,
      0.05,
      1.45,
      false,
      tlGlowPaint,
    );

    canvas.drawArc(
      tlRect,
      0.05,
      1.45,
      false,
      tlCorePaint,
    );

    // ─────────────────────────────────────────────────────────────────────
    // BOTTOM-RIGHT CIRCLE
    // ─────────────────────────────────────────────────────────────────────

    final brCenter = Offset(
      w + 40,
      h + 40,
    );

    const brRadius = 330.0;

    final brRect = Rect.fromCircle(
      center: brCenter,
      radius: brRadius,
    );

    final brShader = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFFFF253B),
        Color(0x99E52535),
        Color(0x33E52535),
        Colors.transparent,
      ],
      stops: [
        0.0,
        0.35,
        0.70,
        1.0,
      ],
    ).createShader(
      Rect.fromLTWH(
        w - brRadius,
        h - brRadius,
        brRadius + 40,
        brRadius + 40,
      ),
    );

    final brGlowPaint = Paint()
      ..shader = brShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        7.5,
      );

    final brCorePaint = Paint()
      ..shader = brShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.solid,
        1.5,
      );

    canvas.drawArc(
      brRect,
      3.20,
      1.45,
      false,
      brGlowPaint,
    );

    canvas.drawArc(
      brRect,
      3.20,
      1.45,
      false,
      brCorePaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}