import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/tab_header.dart';

class AttendanceTab extends StatelessWidget {
  final Map<String, dynamic>? student;
  final VoidCallback onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;

  const AttendanceTab({
    super.key,
    this.student,
    required this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      case 'early-leave':
        return Colors.purple;
      default:
        return AppTheme.gray300;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'present':
        return 'حضور';
      case 'absent':
        return 'غياب';
      case 'late':
        return 'تأخير';
      case 'early-leave':
        return 'خروج مبكر';
      default:
        return '';
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'present':
        return Colors.green.shade100;
      case 'absent':
        return Colors.red.shade100;
      case 'late':
        return Colors.orange.shade100;
      case 'early-leave':
        return Colors.purple.shade100;
      default:
        return AppTheme.gray100;
    }
  }


  @override
  Widget build(BuildContext context) {
    final monthDays = [
      {'date': '2024-12-01', 'status': 'present', 'day': 'الأحد', 'dayNum': 1},
      {'date': '2024-12-02', 'status': 'present', 'day': 'الإثنين', 'dayNum': 2},
      {'date': '2024-12-03', 'status': 'late', 'day': 'الثلاثاء', 'dayNum': 3},
      {'date': '2024-12-04', 'status': 'present', 'day': 'الأربعاء', 'dayNum': 4},
      {'date': '2024-12-05', 'status': 'present', 'day': 'الخميس', 'dayNum': 5},
      {'date': '2024-12-08', 'status': 'present', 'day': 'الأحد', 'dayNum': 8},
      {'date': '2024-12-09', 'status': 'absent', 'day': 'الإثنين', 'dayNum': 9},
      {'date': '2024-12-10', 'status': 'present', 'day': 'الثلاثاء', 'dayNum': 10},
      {'date': '2024-12-11', 'status': 'early-leave', 'day': 'الأربعاء', 'dayNum': 11},
      {'date': '2024-12-12', 'status': 'present', 'day': 'الخميس', 'dayNum': 12},
      {'date': '2024-12-15', 'status': 'present', 'day': 'الأحد', 'dayNum': 15},
      {'date': '2024-12-16', 'status': 'present', 'day': 'الإثنين', 'dayNum': 16},
      {'date': '2024-12-17', 'status': 'late', 'day': 'الثلاثاء', 'dayNum': 17},
      {'date': '2024-12-18', 'status': 'present', 'day': 'الأربعاء', 'dayNum': 18},
      {'date': '2024-12-19', 'status': 'present', 'day': 'الخميس', 'dayNum': 19},
      {'date': '2024-12-22', 'status': 'present', 'day': 'الأحد', 'dayNum': 22},
      {'date': '2024-12-23', 'status': 'present', 'day': 'الإثنين', 'dayNum': 23},
      {'date': '2024-12-24', 'status': 'present', 'day': 'الثلاثاء', 'dayNum': 24},
      {'date': '2024-12-25', 'status': 'present', 'day': 'الأربعاء', 'dayNum': 25},
      {'date': '2024-12-26', 'status': 'present', 'day': 'الخميس', 'dayNum': 26},
    ];

    final stats = {
      'present': monthDays.where((d) => d['status'] == 'present').length,
      'absent': monthDays.where((d) => d['status'] == 'absent').length,
      'late': monthDays.where((d) => d['status'] == 'late').length,
      'earlyLeave': monthDays.where((d) => d['status'] == 'early-leave').length,
    };

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabHeader(
            student: student,
            title: title,
            onShowStudentSelector: onShowStudentSelector,
            onProfileTap: onProfileTap,
            onNotificationTap: () => Navigator.of(context).pushNamed('/notifications'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
          // Statistics Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check_circle_outline_outlined,
                                color: Colors.green, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'حضور',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${stats['present']}',
                        style: AppTheme.tajawal(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.cancel_outlined,
                                color: Colors.red, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'غياب',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${stats['absent']}',
                        style: AppTheme.tajawal(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.access_time_outlined,
                                color: Colors.orange, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'تأخير',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${stats['late']}',
                        style: AppTheme.tajawal(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.logout_outlined,
                                color: Colors.purple, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'خروج مبكر',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${stats['earlyLeave']}',
                        style: AppTheme.tajawal(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Calendar View
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with month and export button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'نوفمبر 2025',
                      style: AppTheme.tajawal(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gray800,
                      ),
                    ),
                      TextButton.icon(
                        onPressed: () {
                          // Simulate PDF export
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle_outline, color: AppTheme.white),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'تم تصدير تقرير الحضور بنجاح',
                                      style: AppTheme.tajawal(
                                        fontSize: 14,
                                        color: AppTheme.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      icon: const Icon(Icons.download, size: 18),
                      label: Text(
                        'تصدير PDF',
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // List of days
                ...monthDays.map((day) {
                  final status = day['status'] as String;
                  final statusColor = _getStatusColor(status);
                  final statusBg = _getStatusBgColor(status);
                  
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/attendanceDetails', arguments: {
                          'student': student,
                          'date': day['date'],
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            // Status indicator circle
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Day name (right side in RTL)
                            Expanded(
                              child: Text(
                                day['day'] as String,
                                textAlign: TextAlign.right,
                                style: AppTheme.tajawal(
                                  fontSize: 14,
                                  color: AppTheme.gray800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Date number
                            Text(
                              '${day['dayNum']}',
                              style: AppTheme.tajawal(
                                fontSize: 14,
                                color: AppTheme.gray500,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Status label pill
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _getStatusText(status),
                                style: AppTheme.tajawal(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
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
}
