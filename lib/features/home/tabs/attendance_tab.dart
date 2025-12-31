import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/dashboard/dashboard_response.dart';
import '../../../core/models/dashboard/attendance_record.dart';
import '../widgets/tab_header.dart';

class AttendanceTab extends StatefulWidget {
  final Map<String, dynamic>? student;
  final DashboardResponse? dashboardResponse;
  final VoidCallback onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;
  final Future<void> Function()? onRefresh;

  const AttendanceTab({
    super.key,
    this.student,
    this.dashboardResponse,
    required this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
    this.onRefresh,
  });

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  String? _selectedStatus;
  DateTime? _selectedDate;

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

  String _formatDate(DateTime date) {
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
    return '${date.day} ${monthNames[date.month]} ${date.year}';
  }

  List<AttendanceRecord> _getFilteredRecords() {
    final monthlyAttendance = widget.dashboardResponse?.monthlyAttendance;
    final recentAttendance = widget.dashboardResponse?.recentAttendance ?? [];
    
    // Combine records from monthly and recent attendance
    final recordsMap = <String, AttendanceRecord>{};
    
    for (final record in monthlyAttendance?.records ?? []) {
      recordsMap[record.id] = record;
    }
    for (final record in recentAttendance) {
      recordsMap[record.id] = record;
    }
    
    var records = recordsMap.values.toList();
    
    // Sort by date descending
    records.sort((a, b) => b.date.compareTo(a.date));
    
    // Apply filters
    if (_selectedStatus != null) {
      records = records.where((r) => r.statusKey == _selectedStatus).toList();
    }
    
    if (_selectedDate != null) {
      records = records.where((r) => 
        r.date.year == _selectedDate!.year &&
        r.date.month == _selectedDate!.month &&
        r.date.day == _selectedDate!.day
      ).toList();
    }
    
    return records;
  }

  @override
  Widget build(BuildContext context) {
    final monthlyAttendance = widget.dashboardResponse?.monthlyAttendance;
    final filteredRecords = _getFilteredRecords();
    
    final stats = {
      'present': monthlyAttendance?.present ?? 0,
      'absent': monthlyAttendance?.absent ?? 0,
      'late': monthlyAttendance?.late ?? 0,
    };

    // Get current month name
    final now = DateTime.now();
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
    final currentMonthName = '${monthNames[now.month]} ${now.year}';

    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
              unreadNotificationsCount: widget.dashboardResponse?.notifications?.unreadCount ?? 0,
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
                                    initialDate: _selectedDate ?? DateTime.now(),
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
                                      _selectedDate = picked;
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
                        child: _buildStatCard(
                          icon: Icons.check_circle_outline_outlined,
                          iconColor: Colors.green,
                          iconBgColor: Colors.green.shade100,
                          label: 'حضور',
                          value: stats['present'] ?? 0,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.cancel_outlined,
                          iconColor: Colors.red,
                          iconBgColor: Colors.red.shade100,
                          label: 'غياب',
                          value: stats['absent'] ?? 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.access_time_outlined,
                          iconColor: Colors.orange,
                          iconBgColor: Colors.orange.shade100,
                          label: 'تأخير',
                          value: stats['late'] ?? 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Attendance Records List
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
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentMonthName,
                              style: AppTheme.tajawal(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.gray800,
                              ),
                            ),
                            if (monthlyAttendance != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${monthlyAttendance.formattedPercentage} حضور',
                                  style: AppTheme.tajawal(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Records List
                        if (filteredRecords.isEmpty)
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
                                    'لا توجد بيانات حضور',
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
                          ...filteredRecords.map((record) => _buildAttendanceRecord(record)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required int value,
  }) {
    return Container(
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
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTheme.tajawal(
                  fontSize: 14,
                  color: AppTheme.gray600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '$value',
            style: AppTheme.tajawal(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.gray800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceRecord(AttendanceRecord record) {
    final statusColor = _getStatusColor(record.statusKey);
    final statusBgColor = _getStatusBgColor(record.statusKey);
    final displayDate = record.entryTime ?? record.date;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/attendanceDetails',
            arguments: {
              'student': widget.student,
              'date': displayDate.toIso8601String(),
              'record': record.toJson(),
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
              // Day name
              Expanded(
                child: Text(
                  record.dayNameArabic,
                  textAlign: TextAlign.right,
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    color: AppTheme.gray800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Date
              Text(
                '${displayDate.day}',
                style: AppTheme.tajawal(
                  fontSize: 14,
                  color: AppTheme.gray500,
                ),
              ),
              const SizedBox(width: 12),
              // Status label
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  record.statusArabic,
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
  }
}
