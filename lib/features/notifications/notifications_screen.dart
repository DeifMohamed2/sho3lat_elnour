import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/notifications_provider.dart';
import '../../core/models/dashboard/notifications_info.dart';
import '../../core/localization/app_localizations.dart';
import 'notification_details_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationsProvider _notificationsProvider = NotificationsProvider();

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    await _notificationsProvider.fetchNotifications();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _refresh() async {
    await _notificationsProvider.refresh();
    if (mounted) {
      setState(() {});
    }
  }

  void _markAllAsRead() async {
    await _notificationsProvider.markAllAsRead();
    if (mounted) {
      setState(() {});
    }
  }

  void _markAsRead(String notificationId) async {
    await _notificationsProvider.markAsRead(notificationId);
    if (mounted) {
      setState(() {});
    }
  }

  IconData _getIconForNotification(NotificationItem notification) {
    switch (notification.type) {
      case 'present':
        return Icons.check_circle;
      case 'absent':
        return Icons.cancel;
      case 'late':
        return Icons.access_time;
      case 'checkout':
        return Icons.exit_to_app;
      case 'announcement':
        return Icons.campaign;
      case 'message':
        return Icons.message;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconColorForNotification(NotificationItem notification) {
    switch (notification.type) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      case 'checkout':
        return Colors.blue;
      case 'announcement':
        return AppTheme.primaryBlue;
      case 'message':
        return Colors.purple;
      default:
        return AppTheme.gray600;
    }
  }

  Color _getIconBgForNotification(NotificationItem notification) {
    switch (notification.type) {
      case 'present':
        return Colors.green.shade100;
      case 'absent':
        return Colors.red.shade100;
      case 'late':
        return Colors.orange.shade100;
      case 'checkout':
        return Colors.blue.shade100;
      case 'announcement':
        return AppTheme.primaryBlue.withOpacity(0.1);
      case 'message':
        return Colors.purple.shade100;
      default:
        return AppTheme.gray100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppTheme.white),
            onPressed: () => Navigator.of(context).pushReplacementNamed('/main', arguments: {'student': null}),
          ),
          title: Text(
            l10n.notifications,
            style: AppTheme.tajawal(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryBlue,
                  AppTheme.primaryBlueDark,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // New count (left side in RTL)
                  if (_notificationsProvider.unreadCount > 0)
                    Text(
                      l10n.newNotificationsCount(_notificationsProvider.unreadCount),
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        color: AppTheme.white.withOpacity(0.9),
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                  // Mark all as read button (right side in RTL)
                  TextButton(
                    onPressed: _notificationsProvider.unreadCount > 0 ? _markAllAsRead : null,
                    child: Text(
                      l10n.markAllAsRead,
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _notificationsProvider.unreadCount > 0
                            ? AppTheme.white
                            : AppTheme.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final l10n = AppLocalizations.of(context);
    if (_notificationsProvider.isLoading && !_notificationsProvider.hasData) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryBlue,
        ),
      );
    }

    if (_notificationsProvider.hasError && !_notificationsProvider.hasData) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.gray400,
            ),
            const SizedBox(height: 16),
            Text(
              _notificationsProvider.errorMessage ?? l10n.error,
              style: AppTheme.tajawal(
                fontSize: 16,
                color: AppTheme.gray600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadNotifications,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: AppTheme.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                l10n.retry,
                style: AppTheme.tajawal(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final notifications = _notificationsProvider.notifications;

    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: AppTheme.gray400,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noNotifications,
              style: AppTheme.tajawal(
                fontSize: 16,
                color: AppTheme.gray600,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: AppTheme.primaryBlue,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ...notifications.map((notification) => _buildNotificationCard(notification)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    final isNew = !notification.isRead;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Mark as read if not already read
            if (isNew) {
              _markAsRead(notification.id);
            }
            // Navigate to notification details
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NotificationDetailsScreen(
                  notification: notification,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon (right side in RTL)
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getIconBgForNotification(notification),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForNotification(notification),
                    color: _getIconColorForNotification(notification),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 8),
                // Content (left side in RTL)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.gray800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.body,
                        style: AppTheme.tajawal(
                          fontSize: 12,
                          color: AppTheme.gray600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.timeAgo,
                        style: AppTheme.tajawal(
                          fontSize: 11,
                          color: AppTheme.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // New indicator dot (to the right of icon in RTL, visually left)
                if (isNew)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

