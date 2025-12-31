import '../constants/api_constants.dart';
import '../models/dashboard/notifications_info.dart';
import '../models/auth/api_error.dart';
import 'api_service.dart';

class NotificationsApiService {
  static final NotificationsApiService _instance = NotificationsApiService._internal();
  factory NotificationsApiService() => _instance;
  NotificationsApiService._internal();

  final ApiService _apiService = ApiService();

  /// Fetch all notifications for the parent
  /// 
  /// Returns [NotificationsResponse] on success
  /// Throws [ApiError] on failure
  Future<NotificationsResponse> getNotifications() async {
    print('🔔 [NOTIFICATIONS API] Fetching notifications...');

    try {
      print('🔔 [NOTIFICATIONS API] Sending request to ${ApiConstants.notificationsEndpoint}');
      
      final response = await _apiService.get(ApiConstants.notificationsEndpoint);

      print('🔔 [NOTIFICATIONS API] Response received, parsing...');
      final notificationsResponse = NotificationsResponse.fromJson(response);
      
      print('🔔 [NOTIFICATIONS API] Notifications parsed successfully');
      print('🔔 [NOTIFICATIONS API] Success: ${notificationsResponse.success}');
      print('🔔 [NOTIFICATIONS API] Total notifications: ${notificationsResponse.meta.total}');
      print('🔔 [NOTIFICATIONS API] Unread count: ${notificationsResponse.meta.unreadCount}');
      print('🔔 [NOTIFICATIONS API] Attendance: ${notificationsResponse.meta.attendance.total} (${notificationsResponse.meta.attendance.unread} unread)');
      print('🔔 [NOTIFICATIONS API] Messages: ${notificationsResponse.meta.message.total} (${notificationsResponse.meta.message.unread} unread)');
      print('🔔 [NOTIFICATIONS API] Financial: ${notificationsResponse.meta.financial.total} (${notificationsResponse.meta.financial.unread} unread)');

      return notificationsResponse;
    } on ApiError catch (e) {
      print('❌ [NOTIFICATIONS API] Request failed with ApiError');
      print('❌ [NOTIFICATIONS API] Error: ${e.message}');
      print('❌ [NOTIFICATIONS API] Status code: ${e.statusCode}');
      rethrow;
    } catch (e) {
      print('❌ [NOTIFICATIONS API] Request failed with unexpected error: $e');
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError.fromString(
        'حدث خطأ أثناء جلب الإشعارات: ${e.toString()}',
      );
    }
  }

  /// Mark a notification as read
  /// 
  /// [notificationId] - The ID of the notification to mark as read
  /// 
  /// Returns true on success
  /// Throws [ApiError] on failure
  Future<bool> markAsRead(String notificationId) async {
    print('🔔 [NOTIFICATIONS API] Marking notification as read: $notificationId');

    try {
      await _apiService.post(
        '${ApiConstants.notificationsEndpoint}/$notificationId/read',
        {},
      );

      print('✅ [NOTIFICATIONS API] Notification marked as read');
      return true;
    } on ApiError catch (e) {
      print('❌ [NOTIFICATIONS API] Mark as read failed: ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ [NOTIFICATIONS API] Mark as read failed with unexpected error: $e');
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError.fromString(
        'حدث خطأ أثناء تحديث الإشعار: ${e.toString()}',
      );
    }
  }

  /// Mark all notifications as read
  /// 
  /// Returns true on success
  /// Throws [ApiError] on failure
  Future<bool> markAllAsRead() async {
    print('🔔 [NOTIFICATIONS API] Marking all notifications as read...');

    try {
      await _apiService.post(
        '${ApiConstants.notificationsEndpoint}/read-all',
        {},
      );

      print('✅ [NOTIFICATIONS API] All notifications marked as read');
      return true;
    } on ApiError catch (e) {
      print('❌ [NOTIFICATIONS API] Mark all as read failed: ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ [NOTIFICATIONS API] Mark all as read failed with unexpected error: $e');
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError.fromString(
        'حدث خطأ أثناء تحديث الإشعارات: ${e.toString()}',
      );
    }
  }
}
