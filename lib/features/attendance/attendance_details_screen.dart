import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? student;
  final String? date;

  const AttendanceDetailsScreen({
    super.key,
    this.student,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final attendanceData = {
      'status': 'حضور',
      'statusColor': Colors.green,
      'date': 'الأربعاء، 18 ديسمبر 2024',
      'entryTime': '7:15 صباحاً',
      'exitTime': '1:45 مساءً',
      'notes': 'حضر الطالب في الموعد المحدد وغادر في نهاية اليوم الدراسي',
      'totalHours': '6 ساعات و 30 دقيقة',
    };

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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: AppTheme.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'تفاصيل الحضور',
                        style: AppTheme.tajawal(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.white,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      attendanceData['date'] as String,
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Status Card
                    Container(
                      padding: const EdgeInsets.all(24),
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
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.login,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            attendanceData['status'] as String,
                            style: AppTheme.tajawal(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            student?['name'] ?? 'محمد أحمد العلي',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Time Details
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
                              const Icon(Icons.access_time, color: AppTheme.primaryBlue, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'تفاصيل الوقت',
                                style: AppTheme.tajawal(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.gray700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildTimeDetail(
                            Icons.login,
                            'وقت الدخول',
                            'دخول إلى المدرسة',
                            attendanceData['entryTime'] as String,
                            Colors.green,
                          ),
                          const SizedBox(height: 12),
                          _buildTimeDetail(
                            Icons.logout,
                            'وقت الانصراف',
                            'خروج من المدرسة',
                            attendanceData['exitTime'] as String,
                            Colors.orange,
                          ),
                          const SizedBox(height: 12),
                          _buildTimeDetail(
                            Icons.timer,
                            'المدة الإجمالية',
                            'وقت البقاء في المدرسة',
                            attendanceData['totalHours'] as String,
                            Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Notes
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
                              const Icon(Icons.note, color: AppTheme.primaryBlue, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'ملاحظات',
                                style: AppTheme.tajawal(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.gray700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            attendanceData['notes'] as String,
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray600,
                              height: 1.6,
                            ),
                          ),
                        ],
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

  Widget _buildTimeDetail(IconData icon, String label, String subtitle, String time, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: AppTheme.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.gray800,
            ),
          ),
        ],
      ),
    );
  }
}

