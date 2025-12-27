import 'package:firebase_messaging/firebase_messaging.dart';
import '../services/notification_service.dart';

/// Helper class for Firebase Cloud Messaging token
///
/// This class provides a way to get FCM token.
class FcmHelper {
  /// Get FCM token
  ///
  /// Returns the FCM token if available, null otherwise
  static Future<String?> getFcmToken() async {
    try {
      print('🔔 [FCM] Getting FCM token...');

      // First, try to get token from NotificationService
      final notificationService = NotificationService();
      final token = notificationService.fcmToken;

      if (token != null && token.isNotEmpty) {
        print(
          '✅ [FCM] Token retrieved from service: ${token.substring(0, 20)}...',
        );
        return token;
      }

      // If token is null, try to get it directly from Firebase
      try {
        print('🔔 [FCM] Attempting to get token directly from Firebase...');
        final directToken = await FirebaseMessaging.instance.getToken();
        if (directToken != null && directToken.isNotEmpty) {
          print(
            '✅ [FCM] Token retrieved directly: ${directToken.substring(0, 20)}...',
          );
          return directToken;
        }
      } catch (firebaseError) {
        print('⚠️ [FCM] Could not get token directly: $firebaseError');
        // Try initializing notification service if not already done
        try {
          print('🔔 [FCM] Attempting to initialize notification service...');
          await notificationService.initialize();
          await Future.delayed(const Duration(milliseconds: 1000));
          final retryToken = notificationService.fcmToken;
          if (retryToken != null && retryToken.isNotEmpty) {
            print(
              '✅ [FCM] Token retrieved after initialization: ${retryToken.substring(0, 20)}...',
            );
            return retryToken;
          }
        } catch (initError) {
          print(
            '❌ [FCM] Failed to initialize notification service: $initError',
          );
        }
      }

      print('⚠️ [FCM] FCM token is null or empty');
      return null;
    } catch (e, stackTrace) {
      print('❌ [FCM] Error getting FCM token: $e');
      print('❌ [FCM] Stack trace: $stackTrace');
      return null;
    }
  }
}
