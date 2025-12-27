import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Top-level function for handling background messages
/// Must be a top-level function, not a class method
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('🔔 [FCM] Background message received: ${message.messageId}');
  print('🔔 [FCM] Title: ${message.notification?.title}');
  print('🔔 [FCM] Body: ${message.notification?.body}');
  print('🔔 [FCM] Data: ${message.data}');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  String? _fcmToken;

  /// Initialize notification service
  Future<void> initialize() async {
    if (_initialized) {
      print('⚠️ [NOTIFICATION] Service already initialized');
      return;
    }

    try {
      print('🔔 [NOTIFICATION] Initializing notification service...');

      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print('❌ [NOTIFICATION] Firebase not initialized - no apps found');
        print('⚠️ [NOTIFICATION] Skipping notification service initialization');
        return;
      }
      
      print('✅ [NOTIFICATION] Firebase is initialized');

      // Request permission for notifications
      await _requestPermission();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token (wait a bit for Firebase to be fully ready)
      await Future.delayed(const Duration(milliseconds: 1000));
      await _getFcmToken();

      // Set up message handlers
      _setupMessageHandlers();

      // Handle token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        print('🔄 [FCM] Token refreshed: ${newToken.substring(0, 20)}...');
        _fcmToken = newToken;
        // TODO: Send updated token to your backend
      });

      _initialized = true;
      print('✅ [NOTIFICATION] Notification service initialized successfully');
    } catch (e, stackTrace) {
      print('❌ [NOTIFICATION] Error initializing notification service: $e');
      print('❌ [NOTIFICATION] Stack trace: $stackTrace');
      // Don't rethrow - allow app to continue without notifications
    }
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    try {
      print('🔔 [NOTIFICATION] Requesting notification permissions...');
      
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('🔔 [NOTIFICATION] Permission status: ${settings.authorizationStatus}');
      
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('✅ [NOTIFICATION] User granted notification permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('⚠️ [NOTIFICATION] User granted provisional notification permission');
      } else {
        print('❌ [NOTIFICATION] User denied notification permission');
      }
    } catch (e) {
      print('❌ [NOTIFICATION] Error requesting permission: $e');
    }
  }

  /// Initialize local notifications for foreground messages
  Future<void> _initializeLocalNotifications() async {
    try {
      print('🔔 [NOTIFICATION] Initializing local notifications...');

      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      // Create notification channel for Android
      const androidChannel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);

      print('✅ [NOTIFICATION] Local notifications initialized');
    } catch (e) {
      print('❌ [NOTIFICATION] Error initializing local notifications: $e');
    }
  }

  /// Get FCM token
  Future<String?> _getFcmToken() async {
    try {
      print('🔔 [NOTIFICATION] Getting FCM token...');
      _fcmToken = await _firebaseMessaging.getToken();
      
      if (_fcmToken != null) {
        print('✅ [NOTIFICATION] FCM token retrieved: ${_fcmToken!.substring(0, 20)}...');
      } else {
        print('⚠️ [NOTIFICATION] FCM token is null');
      }
      
      return _fcmToken;
    } catch (e) {
      print('❌ [NOTIFICATION] Error getting FCM token: $e');
      return null;
    }
  }

  /// Set up message handlers
  void _setupMessageHandlers() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔔 [FCM] Foreground message received: ${message.messageId}');
      print('🔔 [FCM] Title: ${message.notification?.title}');
      print('🔔 [FCM] Body: ${message.notification?.body}');
      print('🔔 [FCM] Data: ${message.data}');

      // Show local notification when app is in foreground
      _showLocalNotification(message);
    });

    // Handle notification taps when app is in foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🔔 [FCM] Notification tapped (app in foreground): ${message.messageId}');
      _handleNotificationTap(message);
    });

    // Check if app was opened from a terminated state via notification
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('🔔 [FCM] App opened from terminated state via notification: ${message.messageId}');
        _handleNotificationTap(message);
      }
    });

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      final notification = message.notification;
      if (notification == null) return;

      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        playSound: true,
        enableVibration: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.show(
        message.hashCode,
        notification.title,
        notification.body,
        details,
        payload: message.data.toString(),
      );

      print('✅ [NOTIFICATION] Local notification shown');
    } catch (e) {
      print('❌ [NOTIFICATION] Error showing local notification: $e');
    }
  }

  /// Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    print('🔔 [NOTIFICATION] Handling notification tap...');
    print('🔔 [NOTIFICATION] Data: ${message.data}');
    
    // TODO: Navigate to appropriate screen based on notification data
    // Example:
    // if (message.data['type'] == 'message') {
    //   Navigator.pushNamed(context, '/messageDetails', arguments: {'id': message.data['id']});
    // }
  }

  /// Handle notification tap from local notification
  void _onNotificationTapped(NotificationResponse response) {
    print('🔔 [NOTIFICATION] Local notification tapped');
    print('🔔 [NOTIFICATION] Payload: ${response.payload}');
    
    // TODO: Handle navigation based on payload
  }

  /// Get current FCM token
  String? get fcmToken => _fcmToken;

  /// Refresh FCM token
  Future<String?> refreshToken() async {
    print('🔄 [NOTIFICATION] Refreshing FCM token...');
    return await _getFcmToken();
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('✅ [NOTIFICATION] Subscribed to topic: $topic');
    } catch (e) {
      print('❌ [NOTIFICATION] Error subscribing to topic $topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('✅ [NOTIFICATION] Unsubscribed from topic: $topic');
    } catch (e) {
      print('❌ [NOTIFICATION] Error unsubscribing from topic $topic: $e');
    }
  }
}

