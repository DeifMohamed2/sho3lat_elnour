import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/localization/app_localizations.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _timer = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_timer > 0) {
            _timer--;
            _startTimer();
          }
        });
      }
    });
  }

  void _handleChange(int index, String value) {
    if (value.length <= 1 && RegExp(r'^\d*$').hasMatch(value)) {
      setState(() {
        _controllers[index].text = value;
      });

      if (value.isNotEmpty && index < 3) {
        _focusNodes[index + 1].requestFocus();
      }

      if (_controllers.every((c) => c.text.isNotEmpty) && index == 3) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushNamed('/selectStudent');
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                      color: AppTheme.gray600,
                    ),
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(
                        l10n.verifyCode,
                        style: AppTheme.tajawal(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.otpSentTo,
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          color: AppTheme.gray500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '+966 5xxxxxxxx',
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          color: AppTheme.primaryBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // OTP Input
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final availableWidth = constraints.maxWidth;
                            // Calculate: 4 items + 3 gaps between them
                            // Use smaller fixed size to ensure it fits on all screens
                            final margin = 3.0; // Fixed margin between items
                            final totalMargins = margin * 3; // 3 gaps between 4 items
                            final maxItemSize = 60.0; // Reduced max size
                            final itemSize = ((availableWidth - totalMargins) / 4).clamp(50.0, maxItemSize);
                            
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                return Container(
                                  width: itemSize,
                                  height: itemSize,
                                  margin: EdgeInsets.only(
                                    right: index < 3 ? margin / 2 : 0,
                                    left: index > 0 ? margin / 2 : 0,
                                  ),
                                  child: TextField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    style: AppTheme.tajawal(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: '',
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
                                    ),
                                    onChanged: (value) => _handleChange(index, value),
                                    onSubmitted: (value) {
                                      if (value.isEmpty && index > 0) {
                                        _focusNodes[index - 1].requestFocus();
                                      }
                                    },
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Resend Timer
                      if (_timer > 0)
                        Text(
                          '${l10n.resendCodeAfter} $_timer ${l10n.seconds}',
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            color: AppTheme.gray500,
                          ),
                          textAlign: TextAlign.center,
                        )
                      else
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _timer = 60;
                            });
                            _startTimer();
                          },
                          icon: const Icon(Icons.refresh, size: 16),
                          label: Text(
                            l10n.resendCode,
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/selectStudent');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: AppTheme.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            l10n.verify,
                            style: AppTheme.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
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
