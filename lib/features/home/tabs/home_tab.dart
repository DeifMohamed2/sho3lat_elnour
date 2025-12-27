import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/tab_header.dart';

class HomeTab extends StatelessWidget {
  final Map<String, dynamic>? student;
  final VoidCallback onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;
  final Function(int)? onSwitchTab;

  const HomeTab({
    super.key,
    this.student,
    required this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
    this.onSwitchTab,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabHeader(
            student: student,
            title: title,
            onShowStudentSelector: onShowStudentSelector,
            onProfileTap: onProfileTap,
            onNotificationTap:
                () => Navigator.of(context).pushNamed('/notifications'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Today's Attendance Status
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
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: AppTheme.primaryBlue,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'حالة الحضور اليوم',
                            style: AppTheme.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.gray700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'حاضر',
                                  style: AppTheme.tajawal(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                                Text(
                                  'وقت الدخول: 7:15 صباحاً',
                                  style: AppTheme.tajawal(
                                    fontSize: 12,
                                    color: AppTheme.gray400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Quick Actions
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
                        'الإجراءات السريعة',
                        style: AppTheme.tajawal(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.gray700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          // First Row - 3 items
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildQuickAction(
                                iconPath: 'assets/icons/check-mark.png',
                                label: 'الحضور',
                                onTap: () => onSwitchTab?.call(1),
                              ),
                              _buildQuickAction(
                                iconPath: 'assets/icons/calendar.png',
                                label: 'الجدول',
                                onTap: () => onSwitchTab?.call(2),
                              ),
                              _buildQuickAction(
                                iconPath: 'assets/icons/certificate.png',
                                label: 'الشهادات',
                                onTap: () => onSwitchTab?.call(3),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Second Row - 3 items
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildQuickAction(
                                iconPath: 'assets/icons/messages.png',
                                label: 'الرسائل',
                                onTap: () => onSwitchTab?.call(4),
                              ),
                              _buildQuickAction(
                                iconPath: 'assets/icons/settings.png',
                                label: 'الإعدادات',
                                onTap:
                                    () => Navigator.of(
                                      context,
                                    ).pushNamed('/settings'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Notifications
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الإشعارات الأخيرة',
                            style: AppTheme.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.gray700,
                            ),
                          ),
                          TextButton(
                            onPressed:
                                () => Navigator.of(
                                  context,
                                ).pushNamed('/notifications'),
                            child: Text(
                              'عرض الكل',
                              style: AppTheme.tajawal(
                                fontSize: 14,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildNotification(
                        icon: Icons.check_circle,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue.shade100,
                        title: 'تم تسجيل حضور الطالب',
                        time: 'منذ ساعة واحدة',
                      ),
                      const SizedBox(height: 12),
                      _buildNotification(
                        icon: Icons.warning_amber_rounded,
                        iconColor: Colors.orange,
                        iconBg: Colors.orange.shade100,
                        title: 'رسالة جديدة من معلم الرياضيات',
                        time: 'منذ ساعتين',
                      ),
                      const SizedBox(height: 12),
                      _buildNotification(
                        icon: Icons.school,
                        iconColor: Colors.green,
                        iconBg: Colors.green.shade100,
                        title: 'نتائج اختبار العلوم متاحة الآن',
                        time: 'منذ 3 ساعات',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
    bool useMaterialIcon = false,
    IconData? materialIcon,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child:
                      useMaterialIcon && materialIcon != null
                          ? Icon(
                            materialIcon,
                            size: 24,
                            color: AppTheme.primaryBlue,
                          )
                          : Image.asset(
                            iconPath,
                            width: 24,
                            height: 24,
                            color: AppTheme.primaryBlue,
                            fit: BoxFit.contain,
                          ),
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  label,
                  style: AppTheme.tajawal(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.gray700,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotification({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.gray800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTheme.tajawal(
                    fontSize: 12,
                    color: AppTheme.gray400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
