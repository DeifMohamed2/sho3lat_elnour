import 'package:flutter/foundation.dart';
import '../models/dashboard/notifications_info.dart';
import '../services/notifications_api_service.dart';
import '../models/auth/api_error.dart';

enum NotificationsStatus { initial, loading, success, error }

class NotificationsProvider extends ChangeNotifier {
  static final NotificationsProvider _instance = NotificationsProvider._internal();
  factory NotificationsProvider() => _instance;
  NotificationsProvider._internal();

  final NotificationsApiService _notificationsService = NotificationsApiService();

  NotificationsResponse? _notificationsResponse;
  NotificationsStatus _status = NotificationsStatus.initial;
  String? _errorMessage;

  // Getters
  NotificationsResponse? get notificationsResponse => _notificationsResponse;
  NotificationsStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == NotificationsStatus.loading;
  bool get hasError => _status == NotificationsStatus.error;
  bool get hasData => _notificationsResponse != null;

  // Notifications getters
  List<NotificationItem> get notifications => _notificationsResponse?.notifications ?? [];
  List<NotificationItem> get unreadNotifications => _notificationsResponse?.unreadNotifications ?? [];
  List<NotificationItem> get attendanceNotifications => _notificationsResponse?.attendanceNotifications ?? [];
  List<NotificationItem> get announcementNotifications => _notificationsResponse?.announcementNotifications ?? [];
  List<NotificationItem> get messageNotifications => _notificationsResponse?.messageNotifications ?? [];
  List<NotificationItem> get financialNotifications => _notificationsResponse?.financialNotifications ?? [];

  // Meta getters
  int get totalCount => _notificationsResponse?.meta.total ?? 0;
  int get unreadCount => _notificationsResponse?.meta.unreadCount ?? 0;
  int get attendanceTotal => _notificationsResponse?.meta.attendance.total ?? 0;
  int get attendanceUnread => _notificationsResponse?.meta.attendance.unread ?? 0;
  int get messageTotal => _notificationsResponse?.meta.message.total ?? 0;
  int get messageUnread => _notificationsResponse?.meta.message.unread ?? 0;
  int get financialTotal => _notificationsResponse?.meta.financial.total ?? 0;
  int get financialUnread => _notificationsResponse?.meta.financial.unread ?? 0;

  /// Fetch notifications from API
  Future<void> fetchNotifications() async {
    print('🔔 [NOTIFICATIONS PROVIDER] Fetching notifications...');
    
    _status = NotificationsStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _notificationsResponse = await _notificationsService.getNotifications();
      _status = NotificationsStatus.success;
      print('✅ [NOTIFICATIONS PROVIDER] Notifications fetched successfully');
      print('✅ [NOTIFICATIONS PROVIDER] Total: $totalCount, Unread: $unreadCount');
    } on ApiError catch (e) {
      _status = NotificationsStatus.error;
      _errorMessage = e.message;
      print('❌ [NOTIFICATIONS PROVIDER] Error: ${e.message}');
    } catch (e) {
      _status = NotificationsStatus.error;
      _errorMessage = 'حدث خطأ غير متوقع';
      print('❌ [NOTIFICATIONS PROVIDER] Unexpected error: $e');
    }

    notifyListeners();
  }

  /// Refresh notifications (alias for fetchNotifications)
  Future<void> refresh() => fetchNotifications();

  /// Mark a notification as read locally (optimistic update)
  void markAsReadLocally(String notificationId) {
    if (_notificationsResponse == null) return;

    final index = _notificationsResponse!.notifications.indexWhere(
      (n) => n.id == notificationId,
    );

    if (index != -1) {
      final notification = _notificationsResponse!.notifications[index];
      if (!notification.isRead) {
        // Create a new notification with isRead = true
        final updatedNotification = NotificationItem(
          id: notification.id,
          title: notification.title,
          body: notification.body,
          type: notification.type,
          category: notification.category,
          data: notification.data,
          isRead: true,
          readAt: DateTime.now(),
          createdAt: notification.createdAt,
          updatedAt: notification.updatedAt,
        );

        // Replace in list
        _notificationsResponse!.notifications[index] = updatedNotification;
        notifyListeners();
      }
    }
  }

  /// Mark a notification as read (API call)
  Future<bool> markAsRead(String notificationId) async {
    print('🔔 [NOTIFICATIONS PROVIDER] Marking notification as read: $notificationId');
    
    // Optimistic update
    markAsReadLocally(notificationId);

    try {
      await _notificationsService.markAsRead(notificationId);
      print('✅ [NOTIFICATIONS PROVIDER] Notification marked as read');
      return true;
    } catch (e) {
      print('❌ [NOTIFICATIONS PROVIDER] Failed to mark as read: $e');
      // Refresh to get correct state
      await fetchNotifications();
      return false;
    }
  }

  /// Mark all notifications as read locally (optimistic update)
  void markAllAsReadLocally() {
    if (_notificationsResponse == null) return;

    final updatedNotifications = _notificationsResponse!.notifications.map((notification) {
      if (!notification.isRead) {
        return NotificationItem(
          id: notification.id,
          title: notification.title,
          body: notification.body,
          type: notification.type,
          category: notification.category,
          data: notification.data,
          isRead: true,
          readAt: DateTime.now(),
          createdAt: notification.createdAt,
          updatedAt: notification.updatedAt,
        );
      }
      return notification;
    }).toList();

    _notificationsResponse = NotificationsResponse(
      success: _notificationsResponse!.success,
      notifications: updatedNotifications,
      meta: NotificationsMeta(
        total: _notificationsResponse!.meta.total,
        unreadCount: 0,
        attendance: NotificationCategoryCount(
          total: _notificationsResponse!.meta.attendance.total,
          unread: 0,
        ),
        message: NotificationCategoryCount(
          total: _notificationsResponse!.meta.message.total,
          unread: 0,
        ),
        financial: NotificationCategoryCount(
          total: _notificationsResponse!.meta.financial.total,
          unread: 0,
        ),
      ),
    );

    notifyListeners();
  }

  /// Mark all notifications as read (API call)
  Future<bool> markAllAsRead() async {
    print('🔔 [NOTIFICATIONS PROVIDER] Marking all notifications as read...');
    
    // Optimistic update
    markAllAsReadLocally();

    try {
      await _notificationsService.markAllAsRead();
      print('✅ [NOTIFICATIONS PROVIDER] All notifications marked as read');
      return true;
    } catch (e) {
      print('❌ [NOTIFICATIONS PROVIDER] Failed to mark all as read: $e');
      // Refresh to get correct state
      await fetchNotifications();
      return false;
    }
  }

  /// Get notifications by category
  List<NotificationItem> getByCategory(String category) {
    return notifications.where((n) => n.category == category).toList();
  }

  /// Get notifications by type
  List<NotificationItem> getByType(String type) {
    return notifications.where((n) => n.type == type).toList();
  }

  /// Clear all data
  void clear() {
    _notificationsResponse = null;
    _status = NotificationsStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }
}
