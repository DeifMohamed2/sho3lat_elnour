import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/dashboard/attendance_record.dart';
import '../../core/localization/app_localizations.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? student;
  final String? date;
  final Map<String, dynamic>? recordData;

  const AttendanceDetailsScreen({
    super.key,
    this.student,
    this.date,
    this.recordData,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      case 'early_leave':
      case 'earlyleave':
        return Colors.blue;
      case 'permission':
        return Colors.purple;
      default:
        return AppTheme.gray600;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return Colors.green.shade100;
      case 'absent':
        return Colors.red.shade100;
      case 'late':
        return Colors.orange.shade100;
      case 'early_leave':
      case 'earlyleave':
        return Colors.blue.shade100;
      case 'permission':
        return Colors.purple.shade100;
      default:
        return AppTheme.gray100;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return Icons.check_circle;
      case 'absent':
        return Icons.cancel;
      case 'late':
        return Icons.access_time;
      case 'early_leave':
      case 'earlyleave':
        return Icons.exit_to_app;
      case 'permission':
        return Icons.assignment_turned_in;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusArabic(String status, AppLocalizations l10n) {
    switch (status.toLowerCase()) {
      case 'present':
        return l10n.presentStatus;
      case 'absent':
        return l10n.absentStatus;
      case 'late':
        return l10n.lateStatus;
      case 'early_leave':
      case 'earlyleave':
        return l10n.earlyLeave;
      case 'permission':
        return l10n.permission;
      default:
        return status;
    }
  }

  String _formatTime(DateTime? dateTime, AppLocalizations l10n) {
    if (dateTime == null) return '--:--';
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour < 12 ? l10n.morning : l10n.evening;
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  String _formatFullDate(DateTime date, AppLocalizations l10n) {
    final dayName = l10n.getDayName(date.weekday);
    final monthName = l10n.getMonthName(date.month);
    return '$dayName، ${date.day} $monthName ${date.year}';
  }

  String _calculateDuration(DateTime? entry, DateTime? exit, AppLocalizations l10n) {
    if (entry == null || exit == null) return '--';
    final duration = exit.difference(entry);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return l10n.hoursAndMinutes(hours, minutes);
    } else if (hours > 0) {
      return l10n.hoursOnly(hours);
    } else {
      return l10n.minutesOnly(minutes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Parse the record data from API
    AttendanceRecord? record;
    if (recordData != null) {
      record = AttendanceRecord.fromJson(recordData!);
    }

    // Fallback date if no record
    DateTime displayDate = DateTime.now();
    if (record != null) {
      displayDate = record.entryTime ?? record.date;
    } else if (date != null) {
      displayDate = DateTime.tryParse(date!) ?? DateTime.now();
    }

    final status = record?.status ?? 'present';
    final statusColor = _getStatusColor(status);
    final statusBgColor = _getStatusBgColor(status);
    final statusIcon = _getStatusIcon(status);
    final statusArabic = _getStatusArabic(status, l10n);

    final entryTime = record?.entryTime;
    final exitTime = record?.exitTime;
    final notes = record?.notes;

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
                        l10n.attendanceDetails,
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
                      color: AppTheme.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _formatFullDate(displayDate, l10n),
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
                            color: Colors.black.withValues(alpha: 0.05),
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
                              color: statusBgColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              statusIcon,
                              color: statusColor,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            statusArabic,
                            style: AppTheme.tajawal(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            student?['name'] ?? '',
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
                              const Icon(Icons.access_time, color: AppTheme.primaryBlue, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                l10n.timeDetails,
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
                            l10n.entryTimeLabel,
                            l10n.schoolEntry,
                            _formatTime(entryTime, l10n),
                            Colors.green,
                          ),
                          const SizedBox(height: 12),
                          _buildTimeDetail(
                            Icons.logout,
                            l10n.exitTime,
                            l10n.schoolExit,
                            _formatTime(exitTime, l10n),
                            Colors.orange,
                          ),
                          const SizedBox(height: 12),
                          _buildTimeDetail(
                            Icons.timer,
                            l10n.totalDuration,
                            l10n.timeAtSchool,
                            _calculateDuration(entryTime, exitTime, l10n),
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
                              const Icon(Icons.note, color: AppTheme.primaryBlue, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                l10n.notes,
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
                            notes?.isNotEmpty == true ? notes! : l10n.noNotes,
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: notes?.isNotEmpty == true ? AppTheme.gray600 : AppTheme.gray400,
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
                    color: iconColor.withValues(alpha: 0.1),
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

