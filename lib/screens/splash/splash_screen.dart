import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';

/// SplashScreen combines:
/// - 🌑 Cinematic Dark-Light Chiaroscuro background with shadow vignette
/// - Delicate glowing red light waves (top & bottom undulating up-down gently, thinner than circle outlines)
/// - Glowing circular outlines in diagonal corners that start dark/intense, get less, and fade into nothing
/// - Squircle logo card with breathing crimson WithMe Red (#E52535) neon back-glow
/// - 🤍 Warm White "With Me" title
/// - ✨ Warm Gold "Your AI Companion" tagline
/// - ✦ Red 4-point diamond star accent divider
/// - Smooth auto-transition to LoginScreen after 2.8 seconds
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

    // Smoothly transition to LoginScreen after 2.8 seconds
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  void _initAnimations() {
    _introController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _introController!,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.90, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController!,
        curve: Curves.easeOutBack,
      ),
    );

    // Subtle breathing pulse for the crimson neon glow
    _pulseController ??= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _pulseController!,
        curve: Curves.easeInOut,
      ),
    );

    if (!_introController!.isAnimating && !_introController!.isCompleted) {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF070B16),
      body: Stack(
        children: [
          // 1. Cinematic Dark-Light Base with Directional Lighting
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF1A2640), // Top-right soft atmospheric dark-light beam
                  Color(0xFF131D32), // Mid-depth navy
                  Color(0xFF090E1A), // Deep shadowy navy
                  Color(0xFF04060E), // Pitch dark shadow bottom-left
                ],
                stops: [0.0, 0.35, 0.70, 1.0],
              ),
            ),
          ),

          // 2. Center-Right Luminous Dark-Light Pool (Illuminating the central brand)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.10, -0.18),
                  radius: 0.95,
                  colors: [
                    const Color(0xFF1F2D4A).withOpacity(0.70), // Radiant dark-light core
                    const Color(0xFF121A2D).withOpacity(0.35),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // 3. Deep Atmospheric Vignette Shadow (Velvety dark shadow falloff at all edges)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.05, -0.15),
                  radius: 1.05,
                  colors: [
                    Colors.transparent,             // Clear illuminated center
                    Color(0x3503060C),              // Gentle penumbra shadow
                    Color(0xB503060C),              // Deep shadow falloff
                    Color(0xF203060C),              // Velvety midnight shadow at edges
                  ],
                  stops: [0.35, 0.65, 0.88, 1.0],
                ),
              ),
            ),
          ),

          // 4. Diagonal Dark Shard Merging — Top-Left to Bottom-Right ambient band
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0, -1.0),
                  end: Alignment(1.0, 1.0),
                  colors: [
                    Color(0x661A2D52), // Top-left dark blue shard entry
                    Color(0x33101E3A), // Mid-diagonal dark shard body
                    Colors.transparent, // Fades to nothing in center
                    Color(0x2210192E), // Bottom-right dark shard tail
                    Color(0x551B2E50), // Bottom-right dark blue shard exit
                  ],
                  stops: [0.0, 0.22, 0.50, 0.78, 1.0],
                ),
              ),
            ),
          ),

          // 4b. Subtle Background Glow — same color family, just a little inner luminance
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, 0.0), // Dead center
                  radius: 0.80,
                  colors: [
                    Color(0x20182E4E), // Very faint navy-blue inner glow — same palette, no color shift
                    Color(0x0E111F38), // Even fainter mid ring
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // 5. Top-Left corner ambient warm red glow (soft merging)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.82, -0.82),
                  radius: 0.90,
                  colors: [
                    const Color(0xFFE52535).withOpacity(0.18), // Warm red accent
                    const Color(0xFF1A2848).withOpacity(0.22), // Dark blue merge
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          // 6. Bottom-Right corner ambient warm red glow (soft merging)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.82, 0.82),
                  radius: 0.90,
                  colors: [
                    const Color(0xFFE52535).withOpacity(0.20), // Warm red accent
                    const Color(0xFF18263F).withOpacity(0.25), // Dark blue merge
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          // 3. Ambient Background Painter: Dark Waves + Glowing Fading Corner Circle Lines
          Positioned.fill(
            child: CustomPaint(
              size: Size(size.width, size.height),
              painter: const _AmbientAtmospherePainter(),
            ),
          ),

          // 4. Central Brand Content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     // Squircle Logo Card — Red shadow from TOP + LEFT + RIGHT only (no bottom)
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
                              // TOP shadow — upward red glow
                              BoxShadow(
                                color: const Color(0xFFE52535).withOpacity(0.55 * glow),
                                blurRadius: 48 * glow,
                                spreadRadius: 2 * glow,
                                offset: Offset(0, -18 * glow), // pushes glow upward
                              ),
                              // LEFT shadow — leftward red glow
                              BoxShadow(
                                color: const Color(0xFFE52535).withOpacity(0.45 * glow),
                                blurRadius: 42 * glow,
                                spreadRadius: 2 * glow,
                                offset: Offset(-16 * glow, 0), // pushes glow left
                              ),
                              // RIGHT shadow — rightward red glow
                              BoxShadow(
                                color: const Color(0xFFE52535).withOpacity(0.45 * glow),
                                blurRadius: 42 * glow,
                                spreadRadius: 2 * glow,
                                offset: Offset(16 * glow, 0), // pushes glow right
                              ),
                              // Core tight halo (all-around, very tight, keeps the card edge lit)
                              BoxShadow(
                                color: const Color(0xFFE52535).withOpacity(0.30 * glow),
                                blurRadius: 18 * glow,
                                spreadRadius: 1 * glow,
                                offset: Offset(0, -4 * glow), // slightly biased upward
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8E2D8), // Warm champagne card base
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                  width: 1.0,
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/withme_logo.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
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

                    // App Title: 🤍 Warm White
                    const Text(
                      AppStrings.appName, // "With Me"
                      style: TextStyle(
                        color: Color(0xFFF5F1E8),
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tagline: ✨ Warm Gold
                    const Text(
                      AppStrings.appTagline, // "Your AI Companion"
                      style: TextStyle(
                        color: Color(0xFFD6B56D),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Red Accent Diamond Star (✦) with fading horizontal wings
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

/// Red 4-point diamond star (✦) with fading horizontal wings
class _RedStarDivider extends StatelessWidget {
  const _RedStarDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Left fading line
        Container(
          width: 50,
          height: 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                const Color(0xFFE52535).withOpacity(0.80),
              ],
            ),
          ),
        ),
        // Central 4-point Diamond Star
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomPaint(
            size: const Size(12, 12),
            painter: _DiamondStarPainter(color: const Color(0xFFE52535)),
          ),
        ),
        // Right fading line
        Container(
          width: 50,
          height: 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFE52535).withOpacity(0.80),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom painter for the 4-point diamond star (✦)
class _DiamondStarPainter extends CustomPainter {
  final Color color;
  _DiamondStarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;

    path.moveTo(cx, 0);
    path.quadraticBezierTo(cx, cy, size.width, cy);
    path.quadraticBezierTo(cx, cy, cx, size.height);
    path.quadraticBezierTo(cx, cy, 0, cy);
    path.quadraticBezierTo(cx, cy, cx, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter that renders:
/// 1. Both dark ambient waves
/// 2. Glowing corner circle lines that start dark/intense, then less, then fade into nothing
class _AmbientAtmospherePainter extends CustomPainter {
  const _AmbientAtmospherePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // =========================================================
    // PART A: DARK OUTLINE WAVES (No glow, no impact — just clean dark lines)
    // =========================================================

    // Simple dark stroke paint — no blur, no glow
    final darkWavePaint = Paint()
      ..color = const Color(0xFF0D1626) // Deep dark navy — very dark, almost invisible
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    // Slightly lighter dark for the bottom wave
    final darkWavePaint2 = Paint()
      ..color = const Color(0xFF111E33) // Slightly warmer dark navy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    // TOP wave: gentle undulation near top of screen
    final topWave = Path();
    topWave.moveTo(-30, h * 0.17);
    topWave.cubicTo(
      w * 0.20, h * 0.11,
      w * 0.38, h * 0.11,
      w * 0.54, h * 0.17,
    );
    topWave.cubicTo(
      w * 0.70, h * 0.23,
      w * 0.86, h * 0.22,
      w + 40, h * 0.16,
    );
    canvas.drawPath(topWave, darkWavePaint);

    // BOTTOM wave: gentle undulation near bottom of screen
    final bottomWave = Path();
    bottomWave.moveTo(-30, h * 0.81);
    bottomWave.cubicTo(
      w * 0.18, h * 0.87,
      w * 0.36, h * 0.88,
      w * 0.52, h * 0.82,
    );
    bottomWave.cubicTo(
      w * 0.68, h * 0.74,
      w * 0.84, h * 0.73,
      w + 40, h * 0.79,
    );
    canvas.drawPath(bottomWave, darkWavePaint2);

    // =========================================================
    // PART B: GLOWING CORNER CIRCLE LINES (Start intense -> less -> nothing)
    // =========================================================

    // 1. Top-Left Circle Line
    final tlCenter = const Offset(-30, -30);
    const tlRadius = 300.0;
    final tlRect = Rect.fromCircle(center: tlCenter, radius: tlRadius);

    final tlShader = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xFFFF253B),                      // Starts intense/vivid
        Color(0x99E52535),                      // Less
        Color(0x33E52535),                      // Even less
        Colors.transparent,                     // Nothing at the end!
      ],
      stops: [0.0, 0.35, 0.70, 1.0],
    ).createShader(Rect.fromLTWH(0, 0, tlRadius + 30, tlRadius + 30));

    // Outer neon glow pass
    final tlGlowPaint = Paint()
      ..shader = tlShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7.0);

    // Crisp core line pass
    final tlCorePaint = Paint()
      ..shader = tlShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 1.5);

    canvas.drawArc(tlRect, 0.05, 1.45, false, tlGlowPaint);
    canvas.drawArc(tlRect, 0.05, 1.45, false, tlCorePaint);

    // 2. Bottom-Right Circle Line
    final brCenter = Offset(w + 40, h + 40);
    const brRadius = 330.0;
    final brRect = Rect.fromCircle(center: brCenter, radius: brRadius);

    final brShader = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFFFF253B),                      // Starts intense/vivid
        Color(0x99E52535),                      // Less
        Color(0x33E52535),                      // Even less
        Colors.transparent,                     // Nothing at the end!
      ],
      stops: [0.0, 0.35, 0.70, 1.0],
    ).createShader(Rect.fromLTWH(w - brRadius, h - brRadius, brRadius + 40, brRadius + 40));

    // Outer neon glow pass
    final brGlowPaint = Paint()
      ..shader = brShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7.5);

    // Crisp core line pass
    final brCorePaint = Paint()
      ..shader = brShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 1.5);

    canvas.drawArc(brRect, 3.20, 1.45, false, brGlowPaint);
    canvas.drawArc(brRect, 3.20, 1.45, false, brCorePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
