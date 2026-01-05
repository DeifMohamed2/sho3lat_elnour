import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'features/auth/splash_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/home/main_layout.dart';
import 'features/profile/parent_profile_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/attendance/attendance_details_screen.dart';
import 'features/messages/message_details_screen.dart';
import 'features/notifications/notifications_screen.dart';
import 'features/settings/terms_and_conditions_screen.dart';
import 'features/settings/about_app_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/services/notification_service.dart';
import 'core/providers/locale_provider.dart';
import 'core/localization/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Firebase
  try {
    print('🔥 [FIREBASE] Initializing Firebase...');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ [FIREBASE] Firebase initialized successfully');

    // Wait a bit to ensure Firebase is fully ready
    await Future.delayed(const Duration(milliseconds: 500));

    // Initialize notification service
    print('🔔 [NOTIFICATION] Initializing notification service...');
    await NotificationService().initialize();
    print('✅ [NOTIFICATION] Notification service initialized');
  } catch (e, stackTrace) {
    print('❌ [FIREBASE] Error initializing Firebase: $e');
    print('❌ [FIREBASE] Stack trace: $stackTrace');
    // Continue app launch even if Firebase fails
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeNotifier = ref.watch(localeProvider);

    return MaterialApp(
      title: 'مدارس شعلة النور',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: localeNotifier.locale,
      supportedLocales: const [Locale('en', ''), Locale('ar', '')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: localeNotifier.textDirection,
          child: child!,
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/main': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>?;
          return MainLayout(student: args?['student']);
        },
        '/parentProfile': (context) => const ParentProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/attendanceDetails': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return AttendanceDetailsScreen(
            student: args['student'],
            date: args['date'],
            recordData: args['record'],
          );
        },
        '/messageDetails': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return MessageDetailsScreen(message: args['message']);
        },
        '/notifications': (context) => const NotificationsScreen(),
        '/termsAndConditions': (context) => const TermsAndConditionsScreen(),
        '/aboutApp': (context) => const AboutAppScreen(),
      },
    );
  }
}
