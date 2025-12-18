import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/auth/splash_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/home/main_layout.dart';
import 'features/profile/student_profile_screen.dart';
import 'features/profile/parent_profile_screen.dart';
import 'features/profile/manage_children_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/attendance/attendance_details_screen.dart';
import 'features/messages/message_details_screen.dart';
import 'features/notifications/notifications_screen.dart';
import 'features/settings/terms_and_conditions_screen.dart';
import 'features/settings/about_app_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدارس شعلة النور',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: const Locale('ar', ''),
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/main': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return MainLayout(student: args?['student']);
        },
        '/profile': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return StudentProfileScreen(student: args?['student']);
        },
        '/parentProfile': (context) => const ParentProfileScreen(),
        '/manageChildren': (context) => const ManageChildrenScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/attendanceDetails': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return AttendanceDetailsScreen(
            student: args['student'],
            date: args['date'],
          );
        },
        '/messageDetails': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return MessageDetailsScreen(message: args['message']);
        },
        '/notifications': (context) => const NotificationsScreen(),
        '/termsAndConditions': (context) => const TermsAndConditionsScreen(),
        '/aboutApp': (context) => const AboutAppScreen(),
      },
    );
  }
}
