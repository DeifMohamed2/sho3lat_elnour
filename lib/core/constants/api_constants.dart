class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://shoalatelnoursystem.site/api';
  
  // Auth endpoints
  static const String loginEndpoint = '/parent/login';
  
  // Get full URL for an endpoint
  static String getUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}


