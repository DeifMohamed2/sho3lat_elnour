import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/dashboard/notifications_info.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationItem notification;

  const NotificationDetailsScreen({
    super.key,
    required this.notification,
  });

  IconData _getIconForNotification() {
    switch (notification.type) {
      case 'present':
        return Icons.check_circle;
      case 'absent':
        return Icons.cancel;
      case 'late':
        return Icons.access_time;
      case 'checkout':
        return Icons.exit_to_app;
      case 'announcement':
        return Icons.campaign;
      case 'message':
        return Icons.message;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColor() {
    switch (notification.type) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      case 'checkout':
        return Colors.blue;
      case 'announcement':
        return AppTheme.primaryBlue;
      case 'message':
        return Colors.purple;
      default:
        return AppTheme.gray600;
    }
  }

  Color _getIconBgColor() {
    switch (notification.type) {
      case 'present':
        return Colors.green.shade100;
      case 'absent':
        return Colors.red.shade100;
      case 'late':
        return Colors.orange.shade100;
      case 'checkout':
        return Colors.blue.shade100;
      case 'announcement':
        return AppTheme.primaryBlue.withValues(alpha: 0.1);
      case 'message':
        return Colors.purple.shade100;
      default:
        return AppTheme.gray100;
    }
  }

  String _getTypeLabel() {
    switch (notification.type) {
      case 'present':
        return 'حضور';
      case 'absent':
        return 'غياب';
      case 'late':
        return 'تأخير';
      case 'checkout':
        return 'انصراف';
      case 'announcement':
        return 'إعلان';
      case 'message':
        return 'رسالة';
      default:
        return 'إشعار';
    }
  }

  String _formatFullDate(DateTime date) {
    final monthNames = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    final dayNames = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];
    final dayName = dayNames[date.weekday % 7];
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'م' : 'ص';
    final minute = date.minute.toString().padLeft(2, '0');
    
    return '$dayName، ${date.day} ${monthNames[date.month]} ${date.year} - $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppTheme.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'تفاصيل الإشعار',
            style: AppTheme.tajawal(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryBlue,
                  AppTheme.primaryBlueDark,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card with Icon and Type
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _getIconBgColor(),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getIconForNotification(),
                        color: _getIconColor(),
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Type Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _getIconColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getTypeLabel(),
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _getIconColor(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Title
                    Text(
                      notification.title,
                      style: AppTheme.tajawal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gray800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Body/Description Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
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
                        Icon(
                          Icons.description_outlined,
                          color: AppTheme.primaryBlue,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'التفاصيل',
                          style: AppTheme.tajawal(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.gray800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      notification.body,
                      style: AppTheme.tajawal(
                        fontSize: 15,
                        color: AppTheme.gray700,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Date/Time Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
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
                        Icon(
                          Icons.access_time,
                          color: AppTheme.primaryBlue,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'التوقيت',
                          style: AppTheme.tajawal(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.gray800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Created Date
                    _buildDateRow(
                      label: 'تاريخ الإرسال',
                      value: _formatFullDate(notification.createdAt),
                    ),
                    if (notification.readAt != null) ...[
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      _buildDateRow(
                        label: 'تاريخ القراءة',
                        value: _formatFullDate(notification.readAt!),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Status Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: notification.isRead 
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.orange.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        notification.isRead ? Icons.done_all : Icons.mark_email_unread,
                        color: notification.isRead ? Colors.green : Colors.orange,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الحالة',
                            style: AppTheme.tajawal(
                              fontSize: 12,
                              color: AppTheme.gray500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            notification.isRead ? 'تم القراءة' : 'غير مقروء',
                            style: AppTheme.tajawal(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: notification.isRead ? Colors.green : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: AppTheme.tajawal(
            fontSize: 13,
            color: AppTheme.gray500,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: AppTheme.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.gray700,
            ),
          ),
        ),
      ],
    );
  }
}
