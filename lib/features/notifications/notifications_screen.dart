import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'isNew': true,
      'icon': Icons.check_circle,
      'iconColor': Colors.green,
      'iconBg': Colors.green.shade100,
      'title': 'تم تسجيل الحضور',
      'description': 'تم تسجيل حضورك بنجاح للفصل الخامس - الفيزياء',
      'time': 'منذ 5 دقائق',
    },
    {
      'id': 2,
      'isNew': true,
      'icon': Icons.info_outline,
      'iconColor': Colors.blue,
      'iconBg': Colors.blue.shade100,
      'title': 'حصة قادمة',
      'description': 'لديك حصة الرياضيات بعد 30 دقيقة - الحصة المقبلة',
      'time': 'منذ 15 دقيقة',
    },
    {
      'id': 3,
      'isNew': false,
      'icon': Icons.description_outlined,
      'iconColor': AppTheme.gray600,
      'iconBg': AppTheme.gray100,
      'title': 'إعلان جديد',
      'description': 'تم نشر جدول الامتحانات النهائية للفصل الدراسي الحالي',
      'time': 'منذ ساعة',
    },
    {
      'id': 4,
      'isNew': false,
      'icon': Icons.warning_amber_rounded,
      'iconColor': Colors.orange,
      'iconBg': Colors.orange.shade100,
      'title': 'تغيير في الجدول',
      'description': 'تم تأجيل حصة العلوم من الساعة 9:00 إلى 10:00',
      'time': 'منذ ساعتين',
    },
    {
      'id': 5,
      'isNew': false,
      'icon': Icons.warning_amber_rounded,
      'iconColor': Colors.orange,
      'iconBg': Colors.orange.shade100,
      'title': 'تذكير',
      'description': 'لا تنسى تسليم الواجب المنزلي لمادة اللغة العربية',
      'time': 'منذ 3 ساعات',
    },
    {
      'id': 6,
      'isNew': false,
      'icon': Icons.info_outline,
      'iconColor': AppTheme.gray600,
      'iconBg': AppTheme.gray100,
      'title': 'تسجيل غياب',
      'description': 'تم تسجيل غيابك عن حصة التاريخ اليوم',
      'time': 'أمس',
    },
    {
      'id': 7,
      'isNew': false,
      'icon': Icons.people_outline,
      'iconColor': AppTheme.gray600,
      'iconBg': AppTheme.gray100,
      'title': 'نشاط جديد',
      'description': 'تم إضافة نشاط رياضي جديد - كرة القدم يوم الخميس',
      'time': 'أمس',
    },
  ];

  int get _newNotificationsCount => _notifications.where((n) => n['isNew'] == true).length;

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isNew'] = false;
      }
    });
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
            onPressed: () => Navigator.of(context).pushReplacementNamed('/main', arguments: {'student': null}),
          ),
          title: Text(
            'الإشعارات',
            style: AppTheme.tajawal(
              fontSize: 24,
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // New count (left side in RTL)
                  if (_newNotificationsCount > 0)
                    Text(
                      '$_newNotificationsCount إشعار جديد',
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        color: AppTheme.white.withOpacity(0.9),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  // Mark all as read button (right side in RTL)
                  TextButton(
                    onPressed: _newNotificationsCount > 0 ? _markAllAsRead : null,
                    child: Text(
                      'تعليم الكل كمقروء',
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _newNotificationsCount > 0
                            ? AppTheme.white
                            : AppTheme.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ..._notifications.map((notification) => _buildNotificationCard(notification)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isNew = notification['isNew'] == true;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle notification tap
            if (isNew) {
              setState(() {
                notification['isNew'] = false;
              });
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                                // Icon (right side in RTL)
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: notification['iconBg'] as Color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notification['icon'] as IconData,
                    color: notification['iconColor'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 8),
                // Content (left side in RTL)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification['title'] as String,
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.gray800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['description'] as String,
                        style: AppTheme.tajawal(
                          fontSize: 12,
                          color: AppTheme.gray600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['time'] as String,
                        style: AppTheme.tajawal(
                          fontSize: 11,
                          color: AppTheme.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // New indicator dot (to the right of icon in RTL, visually left)
                if (isNew)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

