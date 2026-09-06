import 'package:flutter/material.dart';

import '../theme/app_style.dart';
import '../widgets/section_label.dart';
import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _waveController;

  late final Animation<double> _runT = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.22, 0.62, curve: Curves.easeInOut),
  );
  late final Animation<double> _peekT = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.80, 0.94, curve: Curves.easeOut),
  );

  late final Animation<double> _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.75, curve: Curves.elasticOut),
    ),
  );

  late final Animation<double> _logoOpacity = Tween<double>(begin: 0.5, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.65, curve: Curves.easeOut),
    ),
  );

  bool _seatingPromptVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4400),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _seatingPromptVisible = true);
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MenuScreen()),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 190,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: AppColors.cherry,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(110),
                  ),
                ),
                child: _BottomWave(
                  waveController: _waveController,
                  showPrompt: _seatingPromptVisible,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _runT,
              builder: (context, child) {
                final w = MediaQuery.of(context).size.width;
                final x = -190 + (_runT.value * (w + 380));
                return Positioned(left: x, bottom: 215, child: child!);
              },
              child: Image.asset('assets/mascot/rat_run.png', width: 190),
            ),
            AnimatedBuilder(
              animation: _peekT,
              builder: (context, child) {
                final offX = 175 * (1 - _peekT.value);
                return Positioned(
                  right: -offX - 55,
                  top: MediaQuery.of(context).size.height * 0.15,
                  child: child!,
                );
              },
              child: Transform.rotate(
                angle: -0.22,
                child: Image.asset('assets/mascot/rat_peek.png', width: 165),
              ),
            ),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Opacity(
                  opacity: _logoOpacity.value,
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: child,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'La Table',
                      style: AppFonts.pacifico(
                        fontSize: 62,
                        color: AppColors.cherry,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TitleFlourish(centerIsCircle: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomWave extends StatelessWidget {
  final AnimationController waveController;
  final bool showPrompt;

  const _BottomWave({required this.waveController, required this.showPrompt});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -30,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedBuilder(
              animation: waveController,
              builder: (context, child) {
                final opacity = 0.08 + waveController.value * 0.12;
                return Opacity(
                  opacity: opacity,
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              showPrompt ? 'tap anywhere to be seated' : '',
              style: AppFonts.baloo(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dot(0.9),
                const SizedBox(width: 6),
                _dot(0.6),
                const SizedBox(width: 6),
                _dot(0.35),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _dot(double opacity) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}
