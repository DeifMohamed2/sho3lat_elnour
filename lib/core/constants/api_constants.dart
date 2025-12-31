class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://shoalatelnoursystem.site/api';
  
  // Auth endpoints
  static const String loginEndpoint = '/parent/login';
  
  // Dashboard endpoints
  static const String dashboardEndpoint = '/parent/dashboard';
  
  // Notifications endpoints
  static const String notificationsEndpoint = '/parent/notifications';
  
  // Language endpoint
  static const String languageEndpoint = '/parent/language';
  
  // Get full URL for an endpoint
  static String getUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}


