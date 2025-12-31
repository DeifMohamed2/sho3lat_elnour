import 'attendance_record.dart';

class MonthlyAttendance {
  final int present;
  final int late;
  final int absent;
  final int earlyLeave;
  final int permission;
  final int total;
  final double percentage;
  final List<AttendanceRecord> records;

  MonthlyAttendance({
    required this.present,
    required this.late,
    required this.absent,
    required this.earlyLeave,
    required this.permission,
    required this.total,
    required this.percentage,
    required this.records,
  });

  factory MonthlyAttendance.fromJson(Map<String, dynamic> json) {
    return MonthlyAttendance(
      present: json['present'] ?? 0,
      late: json['late'] ?? 0,
      absent: json['absent'] ?? 0,
      earlyLeave: json['earlyLeave'] ?? 0,
      permission: json['permission'] ?? 0,
      total: json['total'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
      records: (json['records'] as List<dynamic>?)
              ?.map((item) => AttendanceRecord.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'present': present,
      'late': late,
      'absent': absent,
      'earlyLeave': earlyLeave,
      'permission': permission,
      'total': total,
      'percentage': percentage,
      'records': records.map((r) => r.toJson()).toList(),
    };
  }

  /// Get attendance stats as a map
  Map<String, int> get stats => {
        'present': present,
        'late': late,
        'absent': absent,
        'earlyLeave': earlyLeave,
        'permission': permission,
      };

  /// Get formatted percentage string
  String get formattedPercentage => '${percentage.toStringAsFixed(1)}%';
}
