import 'student_summary.dart';
import 'selected_student.dart';
import 'today_attendance.dart';
import 'monthly_attendance.dart';
import 'attendance_record.dart';
import 'financial_info.dart';
import 'payments_info.dart';
import 'certificates_info.dart';
import 'notifications_info.dart';
import 'parent_info.dart';

class DashboardResponse {
  final bool success;
  final ParentInfo? parent;
  final List<StudentSummary> students;
  final int totalStudents;
  final SelectedStudent? selectedStudent;
  final TodayAttendance? todayAttendance;
  final MonthlyAttendance? monthlyAttendance;
  final List<AttendanceRecord> recentAttendance;
  final FinancialInfo? financial;
  final PaymentsInfo? payments;
  final CertificatesInfo? certificates;
  final NotificationsInfo? notifications;

  DashboardResponse({
    required this.success,
    this.parent,
    required this.students,
    required this.totalStudents,
    this.selectedStudent,
    this.todayAttendance,
    this.monthlyAttendance,
    required this.recentAttendance,
    this.financial,
    this.payments,
    this.certificates,
    this.notifications,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      success: json['success'] ?? false,
      parent: json['parent'] != null
          ? ParentInfo.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
      students: (json['students'] as List<dynamic>?)
              ?.map((item) => StudentSummary.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalStudents: json['totalStudents'] ?? 0,
      selectedStudent: json['selectedStudent'] != null
          ? SelectedStudent.fromJson(json['selectedStudent'] as Map<String, dynamic>)
          : null,
      todayAttendance: json['todayAttendance'] != null
          ? TodayAttendance.fromJson(json['todayAttendance'] as Map<String, dynamic>)
          : null,
      monthlyAttendance: json['monthlyAttendance'] != null
          ? MonthlyAttendance.fromJson(json['monthlyAttendance'] as Map<String, dynamic>)
          : null,
      recentAttendance: (json['recentAttendance'] as List<dynamic>?)
              ?.map((item) => AttendanceRecord.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      financial: json['financial'] != null
          ? FinancialInfo.fromJson(json['financial'] as Map<String, dynamic>)
          : null,
      payments: json['payments'] != null
          ? PaymentsInfo.fromJson(json['payments'] as Map<String, dynamic>)
          : null,
      certificates: json['certificates'] != null
          ? CertificatesInfo.fromJson(json['certificates'] as Map<String, dynamic>)
          : null,
      notifications: json['notifications'] != null
          ? NotificationsInfo.fromJson(json['notifications'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'parent': parent?.toJson(),
      'students': students.map((s) => s.toJson()).toList(),
      'totalStudents': totalStudents,
      'selectedStudent': selectedStudent?.toJson(),
      'todayAttendance': todayAttendance?.toJson(),
      'monthlyAttendance': monthlyAttendance?.toJson(),
      'recentAttendance': recentAttendance.map((r) => r.toJson()).toList(),
      'financial': financial?.toJson(),
      'payments': payments?.toJson(),
      'certificates': certificates?.toJson(),
      'notifications': notifications?.toJson(),
    };
  }
}
