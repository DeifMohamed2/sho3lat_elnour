import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/api_service.dart';
import '../../core/constants/api_constants.dart';
import '../../core/providers/locale_provider.dart';
import '../../core/localization/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _attendanceNotifications = true;
  bool _messageNotifications = true;
  bool _gradeNotifications = true;
  bool _isChangingLanguage = false;
  final _authService = AuthService();
  final _apiService = ApiService();

  Future<void> _handleLogout() async {
    final l10n = AppLocalizations.of(context);
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              l10n.logout,
              style: AppTheme.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              l10n.logoutConfirmation,
              style: AppTheme.tajawal(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  l10n.cancel,
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  l10n.logout,
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );

    if (shouldLogout == true) {
      // Clear session and navigate to login
      await _authService.logout();
      if (mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/login', (route) => false);
      }
    }
  }

  Future<void> _changeLanguage(String languageCode) async {
    if (_isChangingLanguage) return;

    setState(() {
      _isChangingLanguage = true;
    });

    try {
      // API expects 'EN' or 'AR' in uppercase
      final apiLanguage = languageCode.toUpperCase();

      await _apiService.put(ApiConstants.languageEndpoint, {
        'language': apiLanguage,
      });

      // Update the locale using the provider
      if (mounted) {
        await ref.read(localeProvider.notifier).setLocale(languageCode);
      }

      setState(() {
        _isChangingLanguage = false;
      });

      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: AppTheme.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.languageChangedMessage(languageCode),
                    style: AppTheme.tajawal(
                      fontSize: 14,
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
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
    } catch (e) {
      setState(() {
        _isChangingLanguage = false;
      });

      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: AppTheme.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.languageChangeFailed,
                    style: AppTheme.tajawal(
                      fontSize: 14,
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeNotifier = ref.watch(localeProvider);
    final selectedLanguage = localeNotifier.languageCode;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: AppTheme.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  l10n.settings,
                  style: AppTheme.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Account Section
                  Text(
                    l10n.account,
                    style: AppTheme.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.gray700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSettingsItem(
                          icon: Icons.person,
                          iconColor: Colors.blue,
                          label: l10n.parentProfile,
                          onTap:
                              () => Navigator.of(
                                context,
                              ).pushNamed('/parentProfile'),
                        ),
                        Divider(height: 1, color: AppTheme.borderGray),
                        _buildSettingsItem(
                          icon: Icons.people,
                          iconColor: Colors.purple,
                          label: l10n.changeStudent,
                          onTap: () {
                            // Navigate to main to select student
                            Navigator.of(context).pushReplacementNamed('/main');
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Notifications Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.notifications,
                          style: AppTheme.tajawal(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.gray700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildNotificationToggle(
                          icon: Icons.calendar_today,
                          iconColor: Colors.green,
                          label: l10n.attendanceNotifications,
                          subtitle: l10n.attendanceNotificationsSubtitle,
                          value: _attendanceNotifications,
                          onChanged:
                              (value) => setState(
                                () => _attendanceNotifications = value,
                              ),
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationToggle(
                          icon: Icons.message,
                          iconColor: Colors.orange,
                          label: l10n.messageNotifications,
                          subtitle: l10n.messageNotificationsSubtitle,
                          value: _messageNotifications,
                          onChanged:
                              (value) =>
                                  setState(() => _messageNotifications = value),
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationToggle(
                          icon: Icons.school,
                          iconColor: Colors.blue,
                          label: l10n.gradeNotifications,
                          subtitle: l10n.gradeNotificationsSubtitle,
                          value: _gradeNotifications,
                          onChanged:
                              (value) =>
                                  setState(() => _gradeNotifications = value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // General Section
                  Text(
                    l10n.general,
                    style: AppTheme.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.gray700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSettingsItem(
                          icon: Icons.language,
                          iconColor: Colors.indigo,
                          label: l10n.language,
                          trailing: Text(
                            selectedLanguage == 'ar'
                                ? l10n.arabic
                                : l10n.english,
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray500,
                            ),
                          ),
                          onTap: () => _showLanguageDialog(selectedLanguage),
                        ),
                        // Divider(height: 1, color: AppTheme.borderGray),
                        // _buildSettingsItem(
                        //   icon: Icons.help_outline,
                        //   iconColor: Colors.amber,
                        //   label: 'المساعدة والدعم',
                        // ),
                        Divider(height: 1, color: AppTheme.borderGray),
                        _buildSettingsItem(
                          icon: Icons.description,
                          iconColor: Colors.teal,
                          label: l10n.termsAndConditions,
                          onTap:
                              () => Navigator.of(
                                context,
                              ).pushNamed('/termsAndConditions'),
                        ),
                        Divider(height: 1, color: AppTheme.borderGray),
                        _buildSettingsItem(
                          icon: Icons.info_outline,
                          iconColor: Colors.cyan,
                          label: l10n.aboutApp,
                          trailing: Text(
                            '${l10n.version} ${l10n.versionNumber}',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Delete Account Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showDeleteAccountDialog(context),
                      icon: const Icon(Icons.delete_outline, size: 20),
                      label: Text(
                        l10n.deleteAccount,
                        style: AppTheme.tajawal(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _handleLogout,
                      icon: const Icon(Icons.logout, size: 20),
                      label: Text(
                        l10n.logout,
                        style: AppTheme.tajawal(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: AppTheme.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.gray800,
                  ),
                ),
              ),
              if (trailing != null) trailing,
              if (trailing == null && onTap != null)
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.gray400,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationToggle({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.gray800,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTheme.tajawal(
                    fontSize: 12,
                    color: AppTheme.gray500,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryBlue,
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(String currentLanguage) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.language,
                  color: Colors.indigo,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.selectLanguage,
                  style: AppTheme.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gray800,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                context: dialogContext,
                languageCode: 'ar',
                languageName: 'العربية',
                languageNameSecondary: 'Arabic',
                isSelected: currentLanguage == 'ar',
              ),
              const SizedBox(height: 12),
              _buildLanguageOption(
                context: dialogContext,
                languageCode: 'en',
                languageName: 'English',
                languageNameSecondary: l10n.englishArabic,
                isSelected: currentLanguage == 'en',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                l10n.cancel,
                style: AppTheme.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.gray600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String languageCode,
    required String languageName,
    required String languageNameSecondary,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          Navigator.of(context).pop();
          await _changeLanguage(languageCode);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppTheme.primaryBlue.withOpacity(0.1)
                    : AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.primaryBlue : AppTheme.borderGray,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageName,
                      style: AppTheme.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected
                                ? AppTheme.primaryBlue
                                : AppTheme.gray800,
                      ),
                    ),
                    Text(
                      languageNameSecondary,
                      style: AppTheme.tajawal(
                        fontSize: 12,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppTheme.white,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.deleteAccount,
                  style: AppTheme.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gray800,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.deleteAccountConfirmation,
                style: AppTheme.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.gray800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.deleteAccountWarning,
                style: AppTheme.tajawal(
                  fontSize: 14,
                  color: AppTheme.gray600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.red.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.deleteAccountHint,
                        style: AppTheme.tajawal(
                          fontSize: 12,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                l10n.cancel,
                style: AppTheme.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.gray600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // Simulate account deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppTheme.white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.accountDeletedSuccess,
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
                // Navigate to login after a short delay
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/login', (route) => false);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: AppTheme.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                l10n.deleteAccount,
                style: AppTheme.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
