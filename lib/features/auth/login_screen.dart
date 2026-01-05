import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/auth_service.dart';
import '../../core/models/auth/login_request.dart';
import '../../core/models/auth/api_error.dart';
import '../../core/utils/fcm_helper.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/providers/locale_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _studentCodeController = TextEditingController();
  final _authService = AuthService();
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validateForm);
    _studentCodeController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _studentCodeController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      final phoneText = _phoneController.text.trim();
      final studentCodeText = _studentCodeController.text.trim();
      _isButtonEnabled = phoneText.isNotEmpty && studentCodeText.isNotEmpty;
    });
  }

  /// Extract parent name from student name
  /// For Arabic names like "محمد أحمد العلي", we derive parent name "أحمد محمد العلي"
  String _extractParentName(String studentName) {
    final parts = studentName.trim().split(' ');
    if (parts.length >= 3) {
      // Swap first two parts to get parent name
      // Student: محمد أحمد العلي -> Parent: أحمد محمد العلي
      return '${parts[1]} ${parts[0]} ${parts.sublist(2).join(' ')}';
    } else if (parts.length == 2) {
      return '${parts[1]} ${parts[0]}';
    }
    return studentName; // Return as-is if can't parse
  }

  Future<void> _handleLogin() async {
    if (!_isButtonEnabled || _isLoading) return;

    print('🚀 [LOGIN] Login button pressed');

    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      print('❌ [LOGIN] Form validation failed');
      return;
    }

    print('✅ [LOGIN] Form validation passed');
    setState(() {
      _isLoading = true;
    });

    try {
      final phoneNumber = _phoneController.text.trim();
      final studentCode = _studentCodeController.text.trim();

      print('📱 [LOGIN] Getting FCM token...');
      final fcmToken = await FcmHelper.getFcmToken();
      if (fcmToken != null) {
        print('✅ [LOGIN] FCM token retrieved: ${fcmToken.substring(0, 20)}...');
      } else {
        print(
          '⚠️ [LOGIN] FCM token not available (Firebase Messaging may not be integrated)',
        );
      }

      final loginRequest = LoginRequest(
        phoneNumber: phoneNumber,
        studentCode: studentCode,
        fcmToken: fcmToken,
      );

      print('📝 [LOGIN] Login request created');
      print('📝 [LOGIN] Request details:');
      print('   - Phone: $phoneNumber');
      print('   - Student Code: $studentCode');
      print(
        '   - FCM Token: ${fcmToken != null ? "Provided" : "Not provided"}',
      );

      final loginResponse = await _authService.login(loginRequest);

      print('✅ [LOGIN] Login API call successful');

      // Login successful - navigate to main screen
      // Use the student from the response, or the first student if available
      final student =
          loginResponse.student ??
          (loginResponse.students.isNotEmpty
              ? loginResponse.students.first
              : null);

      print('👤 [LOGIN] Processing student data...');
      print('👤 [LOGIN] Selected student: ${student?.name ?? "None"}');
      print('👤 [LOGIN] Total students: ${loginResponse.students.length}');

      if (student != null) {
        // Convert student model to map for navigation
        final studentMap = {
          'id': student.id,
          'name': student.name,
          'code': student.code,
          'class': student.classInfo?.className ?? '',
          'grade': student.classInfo?.academicLevel ?? '',
          'section': student.classInfo?.section ?? '',
          'totalSchoolFees': student.totalSchoolFees,
          'totalPaid': student.totalPaid,
          'remainingBalance': student.remainingBalance,
        };

        print('👤 [LOGIN] Student map created:');
        print('   - ID: ${studentMap['id']}');
        print('   - Name: ${studentMap['name']}');
        print('   - Code: ${studentMap['code']}');
        print('   - Class: ${studentMap['class']}');

        // Store all students for student selector
        final allStudents =
            loginResponse.students
                .map(
                  (s) => {
                    'id': s.id,
                    'name': s.name,
                    'code': s.code,
                    'class': s.classInfo?.className ?? '',
                    'grade': s.classInfo?.academicLevel ?? '',
                    'section': s.classInfo?.section ?? '',
                    'totalSchoolFees': s.totalSchoolFees,
                    'totalPaid': s.totalPaid,
                    'remainingBalance': s.remainingBalance,
                  },
                )
                .toList();

        print(
          '👥 [LOGIN] All students processed: ${allStudents.length} students',
        );
        print(
          '🎫 [LOGIN] Auth token: ${loginResponse.token.substring(0, 20)}...',
        );

        // Create parent data from the first student's name pattern
        // Assuming parent's name is derived from student's name (e.g., محمد أحمد العلي -> أحمد محمد العلي)
        final phoneNumber = _phoneController.text.trim();
        final parentData = {
          'name': _extractParentName(student.name),
          'phone': phoneNumber,
          'role': 'ولي أمر',
        };

        print(
          '👨‍👩‍👧‍👦 [LOGIN] Parent data: ${parentData['name']} - ${parentData['phone']}',
        );

        // Save session to persistent storage
        print('💾 [LOGIN] Saving session to persistent storage...');
        final sessionSaved = await _authService.saveSession(
          token: loginResponse.token,
          student: studentMap,
          students: allStudents,
          parent: parentData,
        );

        if (sessionSaved) {
          print('✅ [LOGIN] Session saved successfully');
        } else {
          print(
            '⚠️ [LOGIN] Warning: Failed to save session, but continuing...',
          );
        }

        if (mounted) {
          print('🧭 [LOGIN] Navigating to main screen...');
          Navigator.of(context).pushReplacementNamed(
            '/main',
            arguments: {
              'student': studentMap,
              'students': allStudents,
              'token': loginResponse.token,
            },
          );
          print('✅ [LOGIN] Navigation completed successfully!');
        }
      } else {
        print('❌ [LOGIN] No student data found in response');
        throw ApiError.fromString('لم يتم العثور على بيانات الطالب');
      }
    } on ApiError catch (e) {
      print('❌ [LOGIN] Login failed with ApiError');
      print('❌ [LOGIN] Error: ${e.message}');
      if (mounted) {
        _showErrorSnackBar(e.message);
      }
    } catch (e) {
      print('❌ [LOGIN] Login failed with unexpected error: $e');
      if (mounted) {
        _showErrorSnackBar(AppLocalizations.of(context).unexpectedError);
      }
    } finally {
      print('🏁 [LOGIN] Login process finished');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: AppTheme.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTheme.tajawal(fontSize: 14, color: AppTheme.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Language Toggle Button at top-right
              Positioned(
                top: 16,
                right: 16,
                child: Material(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () async {
                      final currentLocale = ref.read(localeProvider).languageCode;
                      final newLocale = currentLocale == 'ar' ? 'en' : 'ar';
                      await ref.read(localeProvider.notifier).setLocale(newLocale);
                      
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              newLocale == 'ar' 
                                  ? 'تم التغيير إلى العربية'
                                  : 'Changed to English',
                              style: AppTheme.tajawal(
                                fontSize: 14,
                                color: AppTheme.white,
                              ),
                            ),
                            backgroundColor: AppTheme.primaryBlue,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.language,
                            color: AppTheme.white,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isRtl ? 'EN' : 'AR',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Logo at the top
              Positioned(
                top: screenHeight * 0.05,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Graduation cap icon in white circle
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/icons/logo-madrasty.png',
                        width: 90,
                        height: 90,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // App Name
                    Text(
                      l10n.appTitle,
                      style: AppTheme.tajawal(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      l10n.parentApp,
                      style: AppTheme.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppTheme.lightBlue,
                      ),
                    ),
                  ],
                ),
              ),
              // White Form Card (Fixed, not scrollable)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxHeight: screenHeight * 0.65),
                  decoration: const BoxDecoration(
                    color: AppTheme.backgroundLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: 24,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Welcome Message
                        Text(
                          l10n.welcome,
                          style: AppTheme.tajawal(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.gray800,
                          ),
                          textAlign: isRtl ? TextAlign.right : TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        // Instructional Text
                        Text(
                          l10n.loginSubtitle,
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: AppTheme.gray500,
                          ),
                          textAlign: isRtl ? TextAlign.right : TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        // Phone Number Field
                        Text(
                          l10n.phoneNumber,
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.gray700,
                          ),
                          textAlign: isRtl ? TextAlign.right : TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textDirection: TextDirection.ltr,
                          onChanged: (_) => _validateForm(),
                          decoration: InputDecoration(
                            hintText: '01xxxxxxxxx',
                            hintStyle: AppTheme.tajawal(
                              color: AppTheme.textGray,
                            ),
                            prefixIcon: const Icon(
                              Icons.phone_outlined,
                              color: AppTheme.textGray,
                            ),
                            filled: true,
                            fillColor: AppTheme.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppTheme.borderGray,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppTheme.borderGray,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppTheme.primaryBlue,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterPhone;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Student Code Field
                        Text(
                          l10n.studentCode,
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.gray700,
                          ),
                          textAlign: isRtl ? TextAlign.right : TextAlign.left,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _studentCodeController,
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.ltr,
                          onChanged: (_) => _validateForm(),
                          decoration: InputDecoration(
                            hintText: l10n.enterStudentCode,
                            hintStyle: AppTheme.tajawal(
                              color: AppTheme.textGray,
                            ),
                            prefixIcon: const Icon(
                              Icons.badge_outlined,
                              color: AppTheme.textGray,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppTheme.borderGray,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppTheme.borderGray,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppTheme.primaryBlue,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterStudentCode;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Login Button
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed:
                                (_isButtonEnabled && !_isLoading)
                                    ? _handleLogin
                                    : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  (_isButtonEnabled && !_isLoading)
                                      ? AppTheme.primaryBlue
                                      : AppTheme.gray300,
                              foregroundColor: AppTheme.white,
                              disabledBackgroundColor: AppTheme.gray300,
                              disabledForegroundColor: AppTheme.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child:
                                _isLoading
                                    ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              AppTheme.white,
                                            ),
                                      ),
                                    )
                                    : Text(
                                      l10n.login,
                                      style: AppTheme.tajawal(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Bottom Text
                        Text(
                          l10n.registerHint,
                          style: AppTheme.tajawal(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppTheme.gray400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
