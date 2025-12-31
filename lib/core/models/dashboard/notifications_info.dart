class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String type;
  final String? category;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.category,
    this.data,
    required this.isRead,
    this.readAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      category: json['category']?.toString(),
      data: json['data'] as Map<String, dynamic>?,
      isRead: json['isRead'] ?? false,
      readAt: json['readAt'] != null
          ? DateTime.tryParse(json['readAt'].toString())
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'body': body,
      'type': type,
      'category': category,
      'data': data,
      'isRead': isRead,
      'readAt': readAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Get formatted time ago string
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} يوم';
    } else {
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
      return '${createdAt.day} ${monthNames[createdAt.month]}';
    }
  }

  /// Check if notification is for attendance
  bool get isAttendance => category == 'attendance';

  /// Check if notification is for announcement
  bool get isAnnouncement => category == 'announcement';

  /// Check if notification is a message
  bool get isMessage => category == 'message';

  /// Check if notification is financial
  bool get isFinancial => category == 'financial';

  /// Get the student name from data if available
  String? get studentName => data?['studentName']?.toString();

  /// Get the certificate ID from data if available
  String? get certificateId => data?['certificateId']?.toString();

  /// Get the certificate title from data if available
  String? get certificateTitle => data?['certificateTitle']?.toString();

  /// Get the action from data if available (uploaded, unlocked, etc.)
  String? get action => data?['action']?.toString();
}

/// Category counts for notifications
class NotificationCategoryCount {
  final int total;
  final int unread;

  NotificationCategoryCount({
    required this.total,
    required this.unread,
  });

  factory NotificationCategoryCount.fromJson(Map<String, dynamic> json) {
    return NotificationCategoryCount(
      total: json['total'] ?? 0,
      unread: json['unread'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'unread': unread,
    };
  }
}

/// Meta information for notifications
class NotificationsMeta {
  final int total;
  final int unreadCount;
  final NotificationCategoryCount attendance;
  final NotificationCategoryCount message;
  final NotificationCategoryCount financial;

  NotificationsMeta({
    required this.total,
    required this.unreadCount,
    required this.attendance,
    required this.message,
    required this.financial,
  });

  factory NotificationsMeta.fromJson(Map<String, dynamic> json) {
    final countsByCategory = json['countsByCategory'] as Map<String, dynamic>? ?? {};
    return NotificationsMeta(
      total: json['total'] ?? 0,
      unreadCount: json['unreadCount'] ?? 0,
      attendance: NotificationCategoryCount.fromJson(
        countsByCategory['attendance'] as Map<String, dynamic>? ?? {},
      ),
      message: NotificationCategoryCount.fromJson(
        countsByCategory['message'] as Map<String, dynamic>? ?? {},
      ),
      financial: NotificationCategoryCount.fromJson(
        countsByCategory['financial'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'unreadCount': unreadCount,
      'countsByCategory': {
        'attendance': attendance.toJson(),
        'message': message.toJson(),
        'financial': financial.toJson(),
      },
    };
  }
}

/// Full notifications response from API
class NotificationsResponse {
  final bool success;
  final List<NotificationItem> notifications;
  final NotificationsMeta meta;

  NotificationsResponse({
    required this.success,
    required this.notifications,
    required this.meta,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      success: json['success'] ?? false,
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((item) => NotificationItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      meta: NotificationsMeta.fromJson(json['meta'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'notifications': notifications.map((n) => n.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }

  /// Get unread notifications
  List<NotificationItem> get unreadNotifications =>
      notifications.where((n) => !n.isRead).toList();

  /// Get attendance notifications
  List<NotificationItem> get attendanceNotifications =>
      notifications.where((n) => n.isAttendance).toList();

  /// Get announcement notifications
  List<NotificationItem> get announcementNotifications =>
      notifications.where((n) => n.isAnnouncement).toList();

  /// Get message notifications
  List<NotificationItem> get messageNotifications =>
      notifications.where((n) => n.isMessage).toList();

  /// Get financial notifications
  List<NotificationItem> get financialNotifications =>
      notifications.where((n) => n.isFinancial).toList();
}

/// Simple info class for dashboard (backward compatibility)
class NotificationsInfo {
  final List<NotificationItem> recent;
  final int unreadCount;

  NotificationsInfo({
    required this.recent,
    required this.unreadCount,
  });

  factory NotificationsInfo.fromJson(Map<String, dynamic> json) {
    return NotificationsInfo(
      recent: (json['recent'] as List<dynamic>?)
              ?.map((item) => NotificationItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recent': recent.map((n) => n.toJson()).toList(),
      'unreadCount': unreadCount,
    };
  }
}
