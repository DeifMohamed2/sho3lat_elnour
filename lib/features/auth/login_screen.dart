import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _phoneController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate() && _isButtonEnabled) {
      // Static credentials
      const String validPhone = '01146101514';
      const String validPassword = '1qaz2wsx';
      
      final enteredPhone = _phoneController.text.trim();
      final enteredPassword = _passwordController.text;
      
      // Validate credentials
      if (enteredPhone != validPhone || enteredPassword != validPassword) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: AppTheme.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'رقم الجوال أو كلمة المرور غير صحيحة',
                    style: AppTheme.tajawal(
                      fontSize: 14,
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        return;
      }
      
      // Login successful - navigate to main screen
      final defaultStudent = {
        'id': 1,
        'name': 'محمد أحمد العلي',
        'grade': 'الصف الخامس',
        'class': '5-أ',
        'avatar': '👦',
        'studentId': 'STD-2024-1234'
      };
      Navigator.of(context).pushReplacementNamed('/main', arguments: {'student': defaultStudent});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryBlue,
                AppTheme.primaryBlueDark,
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
            children: [
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
                      'مدارس شعلة النور',
                      style: AppTheme.tajawal(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      'تطبيق أولياء الأمور',
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
                  constraints: BoxConstraints(
                    maxHeight: screenHeight * 0.65,
                  ),
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
                          'أهلاً بك',
                          style: AppTheme.tajawal(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.gray800,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        // Instructional Text
                        Text(
                          'قم بتسجيل الدخول لمتابعة أداء أبنائك الدراسي',
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: AppTheme.gray500,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 20),
                        // Phone Number Field
                        Text(
                          'رقم الجوال',
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.gray700,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textDirection: TextDirection.ltr,
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
                              return 'الرجاء إدخال رقم الجوال';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        Text(
                          'كلمة المرور',
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.gray700,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: 'أدخل كلمة المرور',
                            hintStyle: AppTheme.tajawal(
                              color: AppTheme.textGray,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppTheme.textGray,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppTheme.textGray,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
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
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: AppTheme.tajawal(
                                fontSize: 14,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Login Button
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isButtonEnabled ? _handleLogin : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isButtonEnabled
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
                            child: Text(
                              'تسجيل الدخول',
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
                          'للحصول على حساب جديد تواصل مع إدارة المدرسة',
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
      ),
    );
  }
}

