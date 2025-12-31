import '../constants/api_constants.dart';
import '../models/dashboard/dashboard_response.dart';
import '../models/auth/api_error.dart';
import 'api_service.dart';

class DashboardService {
  static final DashboardService _instance = DashboardService._internal();
  factory DashboardService() => _instance;
  DashboardService._internal();

  final ApiService _apiService = ApiService();

  /// Fetch the parent dashboard data
  /// 
  /// [studentId] - Optional. If provided, fetches data for that specific student.
  ///               If not provided, uses the currently selected student from the token.
  /// 
  /// Returns [DashboardResponse] on success
  /// Throws [ApiError] on failure
  Future<DashboardResponse> getDashboard({String? studentId}) async {
    print('📊 [DASHBOARD] Fetching dashboard...');
    if (studentId != null) {
      print('📊 [DASHBOARD] Student ID: $studentId');
    } else {
      print('📊 [DASHBOARD] Using default selected student from token');
    }

    try {
      final queryParams = <String, String>{};
      if (studentId != null && studentId.isNotEmpty) {
        queryParams['studentId'] = studentId;
      }

      print('📊 [DASHBOARD] Sending request to ${ApiConstants.dashboardEndpoint}');
      
      final response = await _apiService.get(
        ApiConstants.dashboardEndpoint,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      print('📊 [DASHBOARD] Response received, parsing...');
      final dashboardResponse = DashboardResponse.fromJson(response);
      
      print('📊 [DASHBOARD] Dashboard parsed successfully');
      print('📊 [DASHBOARD] Success: ${dashboardResponse.success}');
      print('📊 [DASHBOARD] Total Students: ${dashboardResponse.totalStudents}');
      print('📊 [DASHBOARD] Selected Student: ${dashboardResponse.selectedStudent?.name ?? "None"}');
      
      if (dashboardResponse.todayAttendance != null) {
        print('📊 [DASHBOARD] Today Attendance: ${dashboardResponse.todayAttendance!.status}');
      }
      
      if (dashboardResponse.monthlyAttendance != null) {
        print('📊 [DASHBOARD] Monthly Attendance: Present=${dashboardResponse.monthlyAttendance!.present}, Absent=${dashboardResponse.monthlyAttendance!.absent}');
      }
      
      if (dashboardResponse.notifications != null) {
        print('📊 [DASHBOARD] Unread Notifications: ${dashboardResponse.notifications!.unreadCount}');
      }

      return dashboardResponse;
    } on ApiError catch (e) {
      print('❌ [DASHBOARD] Request failed with ApiError');
      print('❌ [DASHBOARD] Error: ${e.message}');
      print('❌ [DASHBOARD] Status code: ${e.statusCode}');
      rethrow;
    } catch (e) {
      print('❌ [DASHBOARD] Request failed with unexpected error: $e');
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError.fromString(
        'حدث خطأ أثناء جلب لوحة التحكم: ${e.toString()}',
      );
    }
  }

  /// Switch to a different student and fetch their dashboard
  /// 
  /// [studentId] - The ID of the student to switch to
  /// 
  /// Returns [DashboardResponse] with the new student's data
  Future<DashboardResponse> switchStudent(String studentId) async {
    print('🔄 [DASHBOARD] Switching to student: $studentId');
    return getDashboard(studentId: studentId);
  }
}
