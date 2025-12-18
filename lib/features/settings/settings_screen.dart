import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _attendanceNotifications = true;
  bool _messageNotifications = true;
  bool _gradeNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                    'الإعدادات',
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
                      'الحساب',
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
                            label: 'ملف ولي الأمر',
                            onTap: () => Navigator.of(context).pushNamed('/parentProfile'),
                          ),
                          Divider(height: 1, color: AppTheme.borderGray),
                          _buildSettingsItem(
                            icon: Icons.people,
                            iconColor: Colors.purple,
                            label: 'تغيير الطالب',
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
                            'الإشعارات',
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
                            label: 'إشعارات الحضور',
                            subtitle: 'تنبيهات عند تسجيل الحضور',
                            value: _attendanceNotifications,
                            onChanged: (value) => setState(() => _attendanceNotifications = value),
                          ),
                          const SizedBox(height: 12),
                          _buildNotificationToggle(
                            icon: Icons.message,
                            iconColor: Colors.orange,
                            label: 'إشعارات الرسائل',
                            subtitle: 'تنبيهات الرسائل الجديدة',
                            value: _messageNotifications,
                            onChanged: (value) => setState(() => _messageNotifications = value),
                          ),
                          const SizedBox(height: 12),
                          _buildNotificationToggle(
                            icon: Icons.school,
                            iconColor: Colors.blue,
                            label: 'إشعارات الدرجات',
                            subtitle: 'تنبيهات عند إضافة درجات جديدة',
                            value: _gradeNotifications,
                            onChanged: (value) => setState(() => _gradeNotifications = value),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // General Section
                    Text(
                      'عام',
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
                            label: 'اللغة',
                            trailing: Text(
                              'العربية',
                              style: AppTheme.tajawal(
                                fontSize: 14,
                                color: AppTheme.gray500,
                              ),
                            ),
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
                            label: 'الشروط والأحكام',
                            onTap: () => Navigator.of(context).pushNamed('/termsAndConditions'),
                          ),
                          Divider(height: 1, color: AppTheme.borderGray),
                          _buildSettingsItem(
                            icon: Icons.info_outline,
                            iconColor: Colors.cyan,
                            label: 'حول التطبيق',
                            trailing: Text(
                              'الإصدار 1.0.0',
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
                          'حذف الحساب',
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
                        onPressed: () {
                          // Handle logout
                          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                        },
                        icon: const Icon(Icons.logout, size: 20),
                        label: Text(
                          'تسجيل الخروج',
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
                const Icon(Icons.chevron_right, color: AppTheme.gray400, size: 20),
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

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
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
                    'حذف الحساب',
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
                  'هل أنت متأكد من رغبتك في حذف حسابك؟',
                  style: AppTheme.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.gray800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'سيتم حذف جميع بياناتك وبيانات أبنائك بشكل نهائي ولا يمكن استرجاعها. هذه العملية لا يمكن التراجع عنها.',
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
                      Icon(Icons.info_outline, color: Colors.red.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'يرجى التأكد من رغبتك في المتابعة',
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
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'إلغاء',
                  style: AppTheme.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.gray600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Simulate account deletion
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle, color: AppTheme.white),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'تم حذف الحساب بنجاح',
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
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: AppTheme.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'حذف الحساب',
                  style: AppTheme.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

