import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/auth_service.dart';
import '../../core/localization/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _checkSessionAndNavigate();
  }

  Future<void> _checkSessionAndNavigate() async {
    // Wait for splash animation (2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    try {
      // Initialize auth service and check for saved session
      await _authService.initialize();
      final hasSession = await _authService.hasSavedSession();

      if (hasSession) {
        // Load saved session data
        final sessionData = await _authService.getSavedSession();

        if (sessionData != null && mounted) {
          print('✅ [SPLASH] Found saved session, navigating to main screen');
          // Navigate to main screen with saved session data
          Navigator.of(context).pushReplacementNamed(
            '/main',
            arguments: {
              'student': sessionData['student'],
              'students': sessionData['students'],
              'token': sessionData['token'],
            },
          );
          return;
        }
      }

      // No session found, navigate to login
      if (mounted) {
        print('ℹ️ [SPLASH] No saved session, navigating to login');
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      print('❌ [SPLASH] Error checking session: $e');
      // On error, navigate to login
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppTheme.primaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_controller.value * 0.1),
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/icons/logo-madrasty.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              l10n.appTitle,
              style: AppTheme.tajawal(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppTheme.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.parentApp,
              style: AppTheme.tajawal(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: AppTheme.lightBlue,
              ),
            ),
            const SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final delay = index * 0.15;
                    final animationValue = (_controller.value + delay) % 1.0;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        shape: BoxShape.circle,
                      ),
                      transform: Matrix4.translationValues(
                        0,
                        -10 *
                            (animationValue < 0.5
                                ? animationValue * 2
                                : (1 - animationValue) * 2),
                        0,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
