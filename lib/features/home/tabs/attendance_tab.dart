import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/tab_header.dart';

class AttendanceTab extends StatefulWidget {
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

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  String? _selectedStatus;
  String? _selectedDate;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
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
      default:
        return AppTheme.gray100;
    }
  }

  String _formatDate(String date) {
    final dateParts = date.split('-');
    final dayNum = int.parse(dateParts[2]);
    final monthNum = int.parse(dateParts[1]);
    final year = dateParts[0];
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
    return '$dayNum ${monthNames[monthNum]} $year';
  }

  @override
  Widget build(BuildContext context) {
    final allMonthDays = [
      {'date': '2024-12-01', 'status': 'present', 'day': 'الأحد', 'dayNum': 1},
      {
        'date': '2024-12-02',
        'status': 'present',
        'day': 'الإثنين',
        'dayNum': 2,
      },
      {'date': '2024-12-03', 'status': 'late', 'day': 'الثلاثاء', 'dayNum': 3},
      {
        'date': '2024-12-04',
        'status': 'present',
        'day': 'الأربعاء',
        'dayNum': 4,
      },
      {'date': '2024-12-05', 'status': 'present', 'day': 'الخميس', 'dayNum': 5},
      {'date': '2024-12-08', 'status': 'present', 'day': 'الأحد', 'dayNum': 8},
      {'date': '2024-12-09', 'status': 'absent', 'day': 'الإثنين', 'dayNum': 9},
      {
        'date': '2024-12-10',
        'status': 'present',
        'day': 'الثلاثاء',
        'dayNum': 10,
      },
      {
        'date': '2024-12-11',
        'status': 'present',
        'day': 'الأربعاء',
        'dayNum': 11,
      },
      {
        'date': '2024-12-12',
        'status': 'present',
        'day': 'الخميس',
        'dayNum': 12,
      },
      {'date': '2024-12-15', 'status': 'present', 'day': 'الأحد', 'dayNum': 15},
      {
        'date': '2024-12-16',
        'status': 'present',
        'day': 'الإثنين',
        'dayNum': 16,
      },
      {'date': '2024-12-17', 'status': 'late', 'day': 'الثلاثاء', 'dayNum': 17},
      {
        'date': '2024-12-18',
        'status': 'present',
        'day': 'الأربعاء',
        'dayNum': 18,
      },
      {
        'date': '2024-12-19',
        'status': 'present',
        'day': 'الخميس',
        'dayNum': 19,
      },
      {'date': '2024-12-22', 'status': 'present', 'day': 'الأحد', 'dayNum': 22},
      {
        'date': '2024-12-23',
        'status': 'present',
        'day': 'الإثنين',
        'dayNum': 23,
      },
      {
        'date': '2024-12-24',
        'status': 'present',
        'day': 'الثلاثاء',
        'dayNum': 24,
      },
      {
        'date': '2024-12-25',
        'status': 'present',
        'day': 'الأربعاء',
        'dayNum': 25,
      },
      {
        'date': '2024-12-26',
        'status': 'present',
        'day': 'الخميس',
        'dayNum': 26,
      },
    ];

    // Get unique dates for filter
    final uniqueDates =
        allMonthDays.map((d) => d['date'] as String).toSet().toList()..sort();

    // Filter monthDays based on selected filters
    var filteredDays =
        allMonthDays.where((day) {
          if (_selectedStatus != null && day['status'] != _selectedStatus) {
            return false;
          }
          if (_selectedDate != null && day['date'] != _selectedDate) {
            return false;
          }
          return true;
        }).toList();

    final stats = {
      'present': filteredDays.where((d) => d['status'] == 'present').length,
      'absent': filteredDays.where((d) => d['status'] == 'absent').length,
      'late': filteredDays.where((d) => d['status'] == 'late').length,
    };

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabHeader(
            student: widget.student,
            title: widget.title,
            onShowStudentSelector: widget.onShowStudentSelector,
            onProfileTap: widget.onProfileTap,
            onNotificationTap:
                () => Navigator.of(context).pushNamed('/notifications'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Filter Section
                Container(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.filter_list,
                            color: AppTheme.primaryBlue,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'تصفية',
                            style: AppTheme.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.gray700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.backgroundLight,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppTheme.borderGray,
                                  width: 1,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String?>(
                                  value: _selectedStatus,
                                  isExpanded: true,
                                  hint: Text(
                                    'جميع الحالات',
                                    style: AppTheme.tajawal(
                                      fontSize: 14,
                                      color: AppTheme.gray500,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppTheme.gray600,
                                  ),
                                  items: [
                                    DropdownMenuItem<String?>(
                                      value: null,
                                      child: Text(
                                        'جميع الحالات',
                                        style: AppTheme.tajawal(
                                          fontSize: 14,
                                          color: AppTheme.gray800,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'present',
                                      child: Text(
                                        'حضور',
                                        style: AppTheme.tajawal(
                                          fontSize: 14,
                                          color: AppTheme.gray800,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'absent',
                                      child: Text(
                                        'غياب',
                                        style: AppTheme.tajawal(
                                          fontSize: 14,
                                          color: AppTheme.gray800,
                                        ),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'late',
                                      child: Text(
                                        'تأخير',
                                        style: AppTheme.tajawal(
                                          fontSize: 14,
                                          color: AppTheme.gray800,
                                        ),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedStatus = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      _selectedDate != null
                                          ? DateTime.parse(_selectedDate!)
                                          : DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                  locale: const Locale('ar', ''),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: AppTheme.primaryBlue,
                                          onPrimary: AppTheme.white,
                                          onSurface: AppTheme.gray800,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (picked != null) {
                                  setState(() {
                                    final formattedDate =
                                        '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                                    // Check if the selected date exists in the data
                                    if (uniqueDates.contains(formattedDate)) {
                                      _selectedDate = formattedDate;
                                    } else {
                                      _selectedDate = null;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'لا توجد بيانات لهذا التاريخ',
                                            style: AppTheme.tajawal(
                                              fontSize: 14,
                                              color: AppTheme.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.orange,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundLight,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppTheme.borderGray,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                      color:
                                          _selectedDate != null
                                              ? AppTheme.primaryBlue
                                              : AppTheme.gray500,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _selectedDate != null
                                            ? _formatDate(_selectedDate!)
                                            : 'اختر التاريخ',
                                        style: AppTheme.tajawal(
                                          fontSize: 14,
                                          color:
                                              _selectedDate != null
                                                  ? AppTheme.gray800
                                                  : AppTheme.gray500,
                                        ),
                                      ),
                                    ),
                                    if (_selectedDate != null)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedDate = null;
                                          });
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 16,
                                          color: AppTheme.gray500,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_selectedStatus != null || _selectedDate != null) ...[
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _selectedStatus = null;
                                _selectedDate = null;
                              });
                            },
                            icon: const Icon(Icons.clear, size: 16),
                            label: Text(
                              'مسح التصفية',
                              style: AppTheme.tajawal(
                                fontSize: 12,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
                                  child: const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.green,
                                    size: 16,
                                  ),
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
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                    size: 16,
                                  ),
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
                                  child: const Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
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
                                      const Icon(
                                        Icons.check_circle_outline,
                                        color: AppTheme.white,
                                      ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // List of days
                      if (filteredDays.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 48,
                                  color: AppTheme.gray400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'لا توجد نتائج',
                                  style: AppTheme.tajawal(
                                    fontSize: 16,
                                    color: AppTheme.gray600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...filteredDays.map((day) {
                          final status = day['status'] as String;
                          final statusColor = _getStatusColor(status);
                          final statusBg = _getStatusBgColor(status);

                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/attendanceDetails',
                                  arguments: {
                                    'student': widget.student,
                                    'date': day['date'],
                                  },
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
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
