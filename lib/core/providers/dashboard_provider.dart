import 'package:flutter/foundation.dart';
import '../models/dashboard/dashboard_response.dart';
import '../models/dashboard/student_summary.dart';
import '../models/dashboard/selected_student.dart';
import '../models/dashboard/today_attendance.dart';
import '../models/dashboard/monthly_attendance.dart';
import '../models/dashboard/attendance_record.dart';
import '../models/dashboard/financial_info.dart';
import '../models/dashboard/payments_info.dart';
import '../models/dashboard/certificates_info.dart';
import '../models/dashboard/notifications_info.dart';
import '../models/dashboard/parent_info.dart';
import '../services/dashboard_service.dart';
import '../services/session_storage_service.dart';

enum DashboardStatus {
  initial,
  loading,
  loaded,
  error,
}

class DashboardProvider extends ChangeNotifier {
  static final DashboardProvider _instance = DashboardProvider._internal();
  factory DashboardProvider() => _instance;
  DashboardProvider._internal();

  final DashboardService _dashboardService = DashboardService();
  final SessionStorageService _sessionStorage = SessionStorageService();

  // State
  DashboardStatus _status = DashboardStatus.initial;
  String? _errorMessage;
  DashboardResponse? _dashboardResponse;
  String? _selectedStudentId;

  // Getters
  DashboardStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == DashboardStatus.loading;
  bool get hasError => _status == DashboardStatus.error;
  bool get isLoaded => _status == DashboardStatus.loaded;

  // Data getters
  DashboardResponse? get dashboardResponse => _dashboardResponse;
  ParentInfo? get parent => _dashboardResponse?.parent;
  String get parentName => _dashboardResponse?.parent?.name ?? '';
  String get parentPhone => _dashboardResponse?.parent?.phone ?? '';
  List<StudentSummary> get students => _dashboardResponse?.students ?? [];
  int get totalStudents => _dashboardResponse?.totalStudents ?? 0;
  SelectedStudent? get selectedStudent => _dashboardResponse?.selectedStudent;
  String? get selectedStudentId => _selectedStudentId ?? _dashboardResponse?.selectedStudent?.id;
  TodayAttendance? get todayAttendance => _dashboardResponse?.todayAttendance;
  MonthlyAttendance? get monthlyAttendance => _dashboardResponse?.monthlyAttendance;
  List<AttendanceRecord> get recentAttendance => _dashboardResponse?.recentAttendance ?? [];
  FinancialInfo? get financial => _dashboardResponse?.financial;
  PaymentsInfo? get payments => _dashboardResponse?.payments;
  CertificatesInfo? get certificates => _dashboardResponse?.certificates;
  NotificationsInfo? get notifications => _dashboardResponse?.notifications;
  int get unreadNotificationsCount => _dashboardResponse?.notifications?.unreadCount ?? 0;

  /// Get the current student as a widget-compatible map
  Map<String, dynamic>? get currentStudentMap {
    final student = selectedStudent;
    if (student == null) return null;
    return student.toWidgetMap();
  }

  /// Get all students as widget-compatible maps
  List<Map<String, dynamic>> get studentsMap {
    return students.map((s) => s.toWidgetMap()).toList();
  }

  /// Load the dashboard data
  Future<void> loadDashboard({String? studentId}) async {
    print('📊 [PROVIDER] Loading dashboard...');
    
    _status = DashboardStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dashboardService.getDashboard(studentId: studentId);
      _dashboardResponse = response;
      _selectedStudentId = studentId ?? response.selectedStudent?.id;
      _status = DashboardStatus.loaded;
      
      print('✅ [PROVIDER] Dashboard loaded successfully');
      
      // Save the updated student data to session storage
      if (response.selectedStudent != null) {
        await _saveCurrentStudentToSession();
      }
    } catch (e) {
      print('❌ [PROVIDER] Failed to load dashboard: $e');
      _status = DashboardStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  /// Switch to a different student
  Future<void> switchStudent(String studentId) async {
    print('🔄 [PROVIDER] Switching to student: $studentId');
    
    _selectedStudentId = studentId;
    await loadDashboard(studentId: studentId);
  }

  /// Refresh the current dashboard
  Future<void> refresh() async {
    print('🔄 [PROVIDER] Refreshing dashboard...');
    await loadDashboard(studentId: _selectedStudentId);
  }

  /// Reset the provider state
  void reset() {
    _status = DashboardStatus.initial;
    _errorMessage = null;
    _dashboardResponse = null;
    _selectedStudentId = null;
    notifyListeners();
  }

  /// Save current student to session storage
  Future<void> _saveCurrentStudentToSession() async {
    if (_dashboardResponse?.selectedStudent != null) {
      final studentMap = _dashboardResponse!.selectedStudent!.toWidgetMap();
      await _sessionStorage.initialize();
      await _sessionStorage.saveCurrentStudent(studentMap);
      
      // Also save all students
      final allStudentsMap = students.map((s) => s.toWidgetMap()).toList();
      await _sessionStorage.saveAllStudents(allStudentsMap);
      
      print('💾 [PROVIDER] Student data saved to session');
    }
  }

  /// Get attendance records filtered by status
  List<AttendanceRecord> getFilteredAttendance({String? status}) {
    final allRecords = monthlyAttendance?.records ?? [];
    final recentRecords = recentAttendance;
    
    // Combine and dedupe records
    final recordsMap = <String, AttendanceRecord>{};
    for (final record in [...allRecords, ...recentRecords]) {
      recordsMap[record.id] = record;
    }
    
    var records = recordsMap.values.toList();
    
    // Sort by date descending
    records.sort((a, b) => b.date.compareTo(a.date));
    
    if (status != null && status.isNotEmpty) {
      records = records.where((r) => r.statusKey == status).toList();
    }
    
    return records;
  }

  /// Get attendance stats
  Map<String, int> get attendanceStats {
    final monthly = monthlyAttendance;
    if (monthly == null) {
      return {
        'present': 0,
        'late': 0,
        'absent': 0,
        'earlyLeave': 0,
        'permission': 0,
      };
    }
    return monthly.stats;
  }
}
