import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/dashboard/dashboard_response.dart';
import '../widgets/tab_header.dart';

class HomeTab extends StatelessWidget {
  final Map<String, dynamic>? student;
  final DashboardResponse? dashboardResponse;
  final VoidCallback onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;
  final Function(int)? onSwitchTab;
  final Future<void> Function()? onRefresh;

  const HomeTab({
    super.key,
    this.student,
    this.dashboardResponse,
    required this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
    this.onSwitchTab,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final todayAttendance = dashboardResponse?.todayAttendance;
    final notifications = dashboardResponse?.notifications;
    final unreadCount = notifications?.unreadCount ?? 0;
    
    // Determine attendance status display
    final isPresent = todayAttendance?.isPresent ?? false;
    final isAbsent = todayAttendance?.isAbsent ?? false;
    final isLate = todayAttendance?.isLate ?? false;
    final attendanceStatus = todayAttendance?.statusArabic ?? 'غير متاح';
    final entryTime = todayAttendance?.formattedEntryTime ?? '';
    
    // Determine attendance icon and colors
    IconData attendanceIcon;
    Color attendanceColor;
    Color attendanceBgColor;
    
    if (isPresent) {
      attendanceIcon = Icons.check_circle;
      attendanceColor = Colors.green;
      attendanceBgColor = Colors.green.shade100;
    } else if (isAbsent) {
      attendanceIcon = Icons.cancel;
      attendanceColor = Colors.red;
      attendanceBgColor = Colors.red.shade100;
    } else if (isLate) {
      attendanceIcon = Icons.access_time;
      attendanceColor = Colors.orange;
      attendanceBgColor = Colors.orange.shade100;
    } else {
      attendanceIcon = Icons.help_outline;
      attendanceColor = AppTheme.gray400;
      attendanceBgColor = AppTheme.gray100;
    }

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
              unreadNotificationsCount: unreadCount,
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
                                color: attendanceBgColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                attendanceIcon,
                                color: attendanceColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    attendanceStatus,
                                    style: AppTheme.tajawal(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: attendanceColor,
                                    ),
                                  ),
                                  if (entryTime.isNotEmpty)
                                    Text(
                                      'وقت الدخول: $entryTime',
                                      style: AppTheme.tajawal(
                                        fontSize: 12,
                                        color: AppTheme.gray400,
                                      ),
                                    )
                                  else if (todayAttendance == null)
                                    Text(
                                      'لم يتم تسجيل الحضور بعد',
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
                                iconPath: 'assets/icons/money.png',
                                label: 'المالية',
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
                      if (notifications?.recent.isEmpty ?? true)
                        _buildNotification(
                          icon: Icons.notifications_none,
                          iconColor: AppTheme.gray400,
                          iconBg: AppTheme.gray100,
                          title: 'لا توجد إشعارات جديدة',
                          time: '',
                        )
                      else
                        ...notifications!.recent.take(3).map((notification) {
                          IconData icon;
                          Color iconColor;
                          Color iconBg;
                          
                          switch (notification.category?.toLowerCase() ?? notification.type.toLowerCase()) {
                            case 'attendance':
                              if (notification.type == 'present') {
                                icon = Icons.check_circle;
                                iconColor = Colors.green;
                                iconBg = Colors.green.shade100;
                              } else if (notification.type == 'absent') {
                                icon = Icons.cancel;
                                iconColor = Colors.red;
                                iconBg = Colors.red.shade100;
                              } else {
                                icon = Icons.access_time;
                                iconColor = Colors.orange;
                                iconBg = Colors.orange.shade100;
                              }
                              break;
                            case 'message':
                              icon = Icons.message;
                              iconColor = Colors.blue;
                              iconBg = Colors.blue.shade100;
                              break;
                            case 'payment':
                              icon = Icons.payment;
                              iconColor = Colors.purple;
                              iconBg = Colors.purple.shade100;
                              break;
                            case 'certificate':
                              icon = Icons.school;
                              iconColor = Colors.teal;
                              iconBg = Colors.teal.shade100;
                              break;
                            default:
                              icon = Icons.notifications;
                              iconColor = Colors.blue;
                              iconBg = Colors.blue.shade100;
                          }
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildNotification(
                              icon: icon,
                              iconColor: iconColor,
                              iconBg: iconBg,
                              title: notification.title,
                              time: notification.timeAgo,
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    ));
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
